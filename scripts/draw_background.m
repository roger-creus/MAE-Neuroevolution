function draw_background(sizeX, sizeY, color, offsetDraw)
    fill([-sizeX sizeX sizeX -sizeX], [-sizeY -sizeY sizeY sizeY], color)
    hold on
    for c = -sizeX:1:sizeX
        for r = -sizeY:1:sizeY
            drawSquare(c,r,'w', offsetDraw)
        end
    end
end