package main

import (
	"fmt"
	"sync"
	"time"
)

func worker(id int, data []int, resultChan chan<- int64, wg *sync.WaitGroup) {
	defer wg.Done()

	var localSum int64
	for _, val := range data {
		if val%2 == 0 {
			localSum += int64(val)
		}
	}

	fmt.Printf("Worker %d finished. Partial sum: %d\n", id, localSum)
	resultChan <- localSum
}

func main() {
	const dataSize = 10_000_000
	const numWorkers = 4

	largeSlice := make([]int, dataSize)
	for i := 0; i < dataSize; i++ {
		largeSlice[i] = i + 1
	}

	start := time.Now()

	resultChan := make(chan int64, numWorkers)
	var wg sync.WaitGroup

	chunkSize := (dataSize + numWorkers - 1) / numWorkers

	for i := 0; i < numWorkers; i++ {
		startIdx := i * chunkSize
		endIdx := startIdx + chunkSize

		if startIdx >= dataSize {
			break
		}
		if endIdx > dataSize {
			endIdx = dataSize
		}

		wg.Add(1)
		go worker(i+1, largeSlice[startIdx:endIdx], resultChan, &wg)
	}

	go func() {
		wg.Wait()
		close(resultChan)
	}()

	var totalEvenSum int64
	for partialSum := range resultChan {
		totalEvenSum += partialSum
	}

	elapsed := time.Since(start)

	fmt.Println("--------------------------------------------------")
	fmt.Printf("Total Even Sum : %d\n", totalEvenSum)
	fmt.Printf("Execution Time : %v\n", elapsed)
	fmt.Println("--------------------------------------------------")
}