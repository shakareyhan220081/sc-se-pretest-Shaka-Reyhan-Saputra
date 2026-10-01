import { useState, useCallback } from 'react';
import Board from './components/Board.jsx';
import './App.css';

function App() {
  const [inputRow, setInputRow] = useState(8);
  const [inputCol, setInputCol] = useState(8);

  const [activeRows, setActiveRows] = useState(8);
  const [activeCols, setActiveCols] = useState(8);
  const [knightPos, setKnightPos] = useState({ row: 0, col: 0 });

  const handleGenerateBoard = (e) => {
    e.preventDefault();
    const parsedRow = Math.min(100, Math.max(1, parseInt(inputRow, 10) || 1));
    const parsedCol = Math.min(100, Math.max(1, parseInt(inputCol, 10) || 1));

    setActiveRows(parsedRow);
    setActiveCols(parsedCol);
    setInputRow(parsedRow);
    setInputCol(parsedCol);
    setKnightPos({ row: 0, col: 0 });
  };

  const handleMoveKnight = useCallback((row, col) => {
    setKnightPos({ row, col });
  }, []);

  return (
    <div className='container'>
      <h1 className='title'>Chess Lonely Knight</h1>

      <form className='control-form' onSubmit={handleGenerateBoard}>
        <div className='input-group'>
          <label htmlFor='rowInput'>Row</label>
          <input
            id='rowInput'
            type='number'
            min='1'
            max='100'
            value={inputRow}
            onChange={(e) => setInputRow(e.target.value)}
          />
        </div>

        <div className='input-group'>
          <label htmlFor='colInput'>Column</label>
          <input
            id='colInput'
            type='number'
            min='1'
            max='100'
            value={inputCol}
            onChange={(e) => setInputCol(e.target.value)}
          />
        </div>

        <button type='submit' className='btn-generate'>
          Generate
          <br />
          Board
        </button>
      </form>

      <Board
        rows={activeRows}
        cols={activeCols}
        knightPos={knightPos}
        onMoveKnight={handleMoveKnight}
      />
    </div>
  );
}

export default App;
