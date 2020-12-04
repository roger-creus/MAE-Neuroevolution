function drawPiece(X, Y, Xpre, Ypre, color, off, piece)
    if piece == "enemy"
        fill(Xpre + off, Ypre + off, 'w')
    else
        fill(Xpre + off, Ypre + off, 'w')
    end
    fill(X + off, Y + off, color)
end