function drawSquare(posX, posY, color, off)
    fill([posX-off posX+off posX+off posX-off], [posY-off posY-off posY+off posY+off], color)
end