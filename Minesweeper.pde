import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); 
//ArrayList of just the minesweeper buttons that are mined


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
        clicked = true;
        //your code here
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
        if (MSButton(row, col).isValid()) 
        {
            if(MSButton(row-1, col).isValid() && bombs.contains(buttons[row][col])
            {
                numBombs++;
                MSButton(row-1, col).countBombs();
            }    
            if(MSButton(row+1, col).isValid() && bombs.contains(buttons[row][col])
            {
                numBombs++;
                MSButton(row+1, col).countBombs();
            }    
            if(MSButton(row, col-1).isValid() && bombs.contains(buttons[row][col])
            {
                numBombs++;
                MSButton(row, col-1).countBombs();
            }    
            if(MSButton(row, col+1).isValid() && bombs.contains(buttons[row][col])
            {
                numBombs++;
                MSButton(row, col+1).countBombs();
            }    
            if(MSButton(row-1, col-1).isValid() && bombs.contains(buttons[row][col])
            {
                numBombs++;
                MSButton(row-1, col-1).countBombs();
            }    
            if(MSButton(row+1, col+1).isValid() && bombs.contains(buttons[row][col])
            {
                numBombs++;
                MSButton(row+1, col+1).countBombs();
            }    
            if(MSButton(row+1, col-1).isValid() && bombs.contains(buttons[row][col])
            {
                numBombs++;
                MSButton(row+1, col-1).countBombs();
            }    
            if(MSButton(row-1, col+1).isValid() && bombs.contains(buttons[row][col])
            {
                numBombs++;
                MSButton(row-1, col+1).countBombs();
            }    

        }
        return numBombs;
    }
}



