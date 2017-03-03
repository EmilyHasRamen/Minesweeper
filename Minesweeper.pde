import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined


void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];

    for(int nRow=0; nRow < NUM_ROWS; nRow++)
    {
        for(int nCol=0; nCol < NUM_COLS; nCol++)
        {
            buttons[nRow][nCol] = new MSButton(nRow, nCol);
        }
    }
    
    setBombs();
    //System.out.println()
}
public void setBombs()
{
    //your code
    for(int bNum=0; bNum<=50; bNum++)
    {
        int tempRow=(int)(Math.random()*20);
        int tempCol=(int)(Math.random()*20);
        if(!bombs.contains(buttons[tempRow][tempCol]))
        {
            bombs.add(buttons[tempRow][tempCol]);
        }
    }

}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
    System.out.println("Emily farted, you loser!!!");
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        System.out.println("mousePressed["+r+"]["+c+"](start) marked="+str(marked)+", clicked="+str(clicked) + ", label ={" + label + "}");

        clicked = true;
        //your code here
        if (keyPressed)
        {
            marked =! marked;
            if (!marked)
            {
                clicked = false;
            }
        }
        else if (bombs.contains(this)) 
        {
            displayLosingMessage();
        }
        else if (countBombs(this.r, this.c)>0) 
        {
            label = str(countBombs(this.r, this.c));
        }
        else // no bombs in neighboring buttons
        {
            buttons[r-1][c-1].mousePressed();
            buttons[r][c-1].mousePressed();
            buttons[r+1][c-1].mousePressed();
            buttons[r][c-1].mousePressed();
            buttons[r][c+1].mousePressed();
            buttons[r-1][c+1].mousePressed();
            buttons[r][c+1].mousePressed();
            buttons[r+1][c+1].mousePressed();
        }

        System.out.println("mousePressed["+r+"]["+c+"](end) marked="+str(marked)+", clicked="+str(clicked) + ", label ={" + label + "}");
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
        fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if (r<20 && c<20) 
        {
            return true;
        }
        
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        /*
        if (buttons[row][col].isValid(row,col)) 
        {
            if(buttons[row-1][col].isValid(row-1,col) && bombs.contains(buttons[row][col]))
            {
                numBombs++;
            }    
            if(buttons[row+1][col].isValid(row+1, col) && bombs.contains(buttons[row][col]))
            {
                numBombs++;
            }    
            if(buttons[row][col-1].isValid(row,col-1) && bombs.contains(buttons[row][col]))
            {
                numBombs++;
            }    
            if(buttons[row][col+1].isValid(row,col+1) && bombs.contains(buttons[row][col]))
            {
                numBombs++;
            }    
            if(buttons[row-1][col-1].isValid(row-1,col-1) && bombs.contains(buttons[row][col]))
            {
                numBombs++;
            }    
            if(buttons[row+1][col+1].isValid(row+1,col+1) && bombs.contains(buttons[row][col]))
            {
                numBombs++;
            }    
            if(buttons[row+1][col-1].isValid(row+1,col-1) && bombs.contains(buttons[row][col]))
            {
                numBombs++;
            }    
            if(buttons[row-1][col+1].isValid(row-1,col+1) && bombs.contains(buttons[row][col]))
            {
                numBombs++;
            }    

        }
        */
        for ( int i=row-1; i<=row+1; i++ )
            for ( int j=col-1; j<=col+1; j++ )
            {
                if( (i==row) && (j==col) )
                {
                    // do nothing
                }
                else
                {
                    if(buttons[i][j].isValid(i,j) && bombs.contains(buttons[i][j]))
                    {
                        numBombs++;
                    }
                }
            }
        
        System.out.println("countBombs[" + row + "][" + col + "] = " + numBombs);
        return numBombs;
    }
}



