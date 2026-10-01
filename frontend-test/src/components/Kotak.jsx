import React, { useState } from 'react';

const Kotak = ({ row, col, isKnight, isBlack, knightPos, onMoveKnight }) => {
  const [isHovered, setIsHovered] = useState(false);

  // gerakan L kuda
  const isValidKnightMove = (fromRow, fromCol, toRow, toCol) => {
    const dRow = Math.abs(fromRow - toRow);
    const dCol = Math.abs(fromCol - toCol);
    return (dRow === 1 && dCol === 2) || (dRow === 2 && dCol === 1);
  };

  const isMoveAllowed = isValidKnightMove(knightPos.row, knightPos.col, row, col);

  const handleClick = () => {
    if (isMoveAllowed) {
      onMoveKnight(row, col);
    }
  };

  // Hover 
  let backgroundColor = isBlack ? '#000000' : '#ffffff';
  if (isHovered) {
    if (isKnight || !isMoveAllowed) {
      backgroundColor = '#ff0000'; // Merah jika posisi kuda saat ini atau langkah ilegal
    } else {
      backgroundColor = '#00ff00'; // Hijau jika langkah valid
    }
  }

  return (
    <div
      onClick={handleClick}
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
      style={{
        backgroundColor,
        width: '40px',
        height: '40px',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        cursor: isMoveAllowed ? 'pointer' : 'default',
        boxSizing: 'border-box',
        userSelect: 'none',
      }}
    >
      {isKnight && (
        <span
          style={{
            color: '#ff0000',
            fontWeight: 'bold',
            fontSize: '1.25rem',
            lineHeight: 1,
          }}
        >
          K
        </span>
      )}
    </div>
  );
};

export default React.memo(Kotak);