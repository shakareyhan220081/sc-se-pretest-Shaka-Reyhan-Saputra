import Kotak from './Kotak';

const Board = ({ rows, cols, knightPos, onMoveKnight }) => {
  const cells = [];

  for (let r = 0; r < rows; r++) {
    for (let c = 0; c < cols; c++) {
      const isBlack = (r + c) % 2 === 0;
      const isKnight = knightPos.row === r && knightPos.col === c;

      cells.push(
        <Kotak
          key={`${r}-${c}`}
          row={r}
          col={c}
          isBlack={isBlack}
          isKnight={isKnight}
          knightPos={knightPos}
          onMoveKnight={onMoveKnight}
        />,
      );
    }
  }

  return (
    <div
      style={{
        display: 'grid',
        gridTemplateColumns: `repeat(${cols}, 40px)`,
        gridTemplateRows: `repeat(${rows}, 40px)`,
        border: '1px solid #000000',
        width: 'fit-content',
        margin: '24px auto 40px auto',
        overflow: 'auto',
        maxWidth: '90vw',
        maxHeight: '70vh',
      }}
    >
      {cells}
    </div>
  );
};

export default Board;
