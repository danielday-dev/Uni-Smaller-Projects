#Patchwork Coursework by Daniel Day; up2018443

#imports

from graphics import *

#functions

def main():
    colours, patchworkSize = getInputs()
    win, patches = drawPatchwork(colours, patchworkSize)
    controlPatchwork(win, patches, colours)

#main functions
def getInputs():
    '''gets and returns inputs'''
    validColours = ["red", "green", "blue", "magenta", "orange", "cyan"]
    colours = []
    while len(colours) < 3:
        colour = input(f"Please enter colour number {len(colours)+1} \n").lower()
        if colour in validColours and \
            sum(1 for item in colours if colour == item) < 2:
                colours.append(colour)
        else:
            print("Colour error")

    validSizes = [5, 7]
    patchworkSize = -1
    while patchworkSize not in validSizes:
        size = int(input(f"Please enter the size of the patchwork valid sizes are  {validSizes} \n"))
        if size in validSizes:
            patchworkSize = size
        else:
            print("SizeError: the size you entered was not valid")
    return colours, patchworkSize

def drawPatchwork(colours, patchworkSize):
    '''draws and returns the main body of patches and returns the patchwork'''
    winX = patchworkSize * 100
    winY = patchworkSize * 100
    win = GraphWin("Patchwork", winX, winY, autoflush = False)
    patches = []

    for i in range(0, patchworkSize * 100, 100):
        for j in range(0, patchworkSize * 100, 100):
            #determine patch colour
            if i < (pairOfJ := patchworkSize * 100 - 100 - j):
                colour = colours[0]
            elif i == pairOfJ:
                colour = colours[1]
            else:
                colour = colours[2]

            #determine patch type
            if i % 200 == 0 and i >= pairOfJ:
                patchType = 2
            else:
                patchType = 1

            patch = drawPatch(win, i, j, colour, patchType)
            patches.append(patch)
    return win, patches

def drawPatch(win, x, y, colour, patchType):
    if patchType == 1:
        patch = drawNormPatch(win, x, y, colour)
    elif patchType == 2:
        patch = drawFinPatch(win, x, y, colour)
    return patch

def drawNormPatch(win, x, y, colour):
    patch = []
    for i in range(0, 100, 20):
        for j in range(0, 100, 20):
            topLeft = Point(x + i, y + j)
            bottomRight = Point(x + i + 20, y + j + 20)
            #work out colour of rect and circle
            if i % 40 == 0 and j % 40 == 0 or \
            i % 40 == 20 and j % 40 == 20:
                rectColour = colour
                circleColour = "white"
            else:
                rectColour = "white"
                circleColour = colour
            rectangle = drawRectangle(win, topLeft,
                        bottomRight, colour = rectColour)
            patch.append(rectangle)
            #draw circles on the rectangles
            for k in range(5, 25, 10):
                for l in range(5, 25, 10):
                    centre = Point(x + i + k, y + j + l)
                    radius = 5
                    circle = drawCircle(win, centre, radius, circleColour)
                    patch.append(circle)
    return patch

def drawFinPatch(win, x, y, colour):
    patch = []
    for i in range(0, 50, 5):
        topLeft = Point(x + i, y + i)
        bottomRight = Point(x + 100 - i, y + 100 - i)
        rectangle = drawRectangle(win, topLeft, bottomRight,
        colour = colour if i % 10 == 0 else "white")
        patch.append(rectangle)
    return patch

def controlPatchwork(win, patches, colours):
    '''allows the user to interact with the patchwork'''
    from time import sleep
    running = True
    emptySpace = []
    selected = False
    while running:

        #select something
        if not selected:
            mouseLocation = win.getMouse()
            patchX = mouseLocation.getX()//100
            patchY = mouseLocation.getY()//100
            topLeft = Point(patchX*100, patchY*100)
            bottomRight = Point(patchX*100 + 100, patchY*100 + 100)
            selectionBox = drawRectangle(win, topLeft, bottomRight, 5)
        selected = True

        key = win.checkKey()
        #delete a patch
        if key == "d":
            if not checkPatch(topLeft, emptySpace):
                patch = getPatchFromPatches(topLeft, patches)
                if patch:
                    emptySpace.append(topLeft)

                    for patchPart in patch:
                        patchPart.undraw()
                    patches.remove(patch)
            else:
                print("Cannot delete nothing")

        #draw new patches
        elif key in ["1", "2", "3"]:
            redrawPatch(emptySpace, win, topLeft,
                colours, int(key)-1, 2, patches)

        elif key in ["4", "5", "6"]:
            redrawPatch(emptySpace, win, topLeft,
                colours, int(key)-4, 1, patches)

        elif key == "Escape":
            selected = False
            selectionBox.undraw()

        #movement
        elif key == "Up":
            destination = Point(topLeft.getX(), topLeft.getY() - 100)
            movePatch(win, 0, -4, emptySpace, destination, topLeft, patches)

        elif key == "Down":
            destination = Point(topLeft.getX(), topLeft.getY() + 100)
            movePatch(win, 0, 4, emptySpace, destination, topLeft, patches)

        elif key == "Left":
            destination = Point(topLeft.getX() - 100, topLeft.getY())
            movePatch(win, -4, 0, emptySpace, destination, topLeft, patches)

        elif key == "Right":
            destination = Point(topLeft.getX() + 100, topLeft.getY())
            movePatch(win, 4, 0, emptySpace, destination, topLeft, patches)

        elif key != "":
            print("keyError")

        if selected:
            #fixes the box getting smaller if a new patch is drawn
            selectionBox.undraw()
            selectionBox.draw(win)

        key = ""

def redrawPatch(emptySpace, win, topLeft, colours, key, patchType, patches):
    for point in emptySpace:
        if comparePoints(point, topLeft):
            colour = colours[key]
            patch = drawPatch(win, topLeft.getX(), topLeft.getY(), colour, patchType)
            patches.append(patch)
            emptySpace.remove(point)

def movePatch(win, dx, dy, emptySpace, destination, topLeft, patches):
    if checkPatch(destination, emptySpace):
        patch = getPatchFromPatches(topLeft, patches)
        if patch:
            animatePatch(win, patch, dx, dy)
            removePoint(destination, emptySpace)
            emptySpace.append(topLeft)
        else:
            print("Error: Patch doesnt exist")
    else:
        print("Invalid Destination")

def animatePatch(win, patch, dx, dy):
    from time import sleep
    for i in range(25):
        for patchPart in patch:
            patchPart.move(dx, dy)
        win.update()
        sleep(0.1)

def checkPatch(point, emptySpace):
    '''Returns True if space is empty'''
    empty = False
    for space in emptySpace:
        if comparePoints(point, space):
            empty = True
    return empty

def removePoint(point, l):
    '''removes a point from a list'''
    for p in l:
        if comparePoints(p, point):
            l.remove(p)

def comparePoints(p1, p2):
    '''Compares two points to see if they have the same coordinates'''
    return True if p1.getX() == p2.getX() and p1.getY() == p2.getY() else False

def getPatchFromPatches(p, patches):
    '''returns a patch that has the given coords'''
    for patch in patches:
        if comparePoints(patch[0].getP1(), p):
            return patch
    return False

def drawCircle(win, centre, radius, colour):
    circle = Circle(centre, radius)
    circle.setFill(colour)
    circle.setOutline(colour)
    circle.draw(win)
    return circle

def drawRectangle(win, topLeft, bottomRight, width = False, colour = False):
    rectangle = Rectangle(topLeft, bottomRight)
    if colour:
        rectangle.setFill(colour)
        rectangle.setOutline(colour)
    if width:
        rectangle.setWidth(width)
    rectangle.draw(win)
    return rectangle

#run
main()