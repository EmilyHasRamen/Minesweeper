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
    for(int bNum=0; bNum<=60; bNum++)
    {
        int tempRow=(int)(Math.random()*20);
        int tempCol=(int)(Math.random()*20);
        if(!bombs.contains(buttons[tempRow][tempCol]))
        {
            bombs.add(buttons[tempRow][tempCol]);
//buttons[tempRow][tempCol].clicked = true;           // DEBUG CODE
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
    for(int r=0; r<NUM_ROWS; r++)
    {
        for(int c=0; c<NUM_COLS; c++)
        {
            if( (!buttons[r][c].isClicked()==true) && (!bombs.contains(buttons[r][c])) )
            {
                return false;
            }
    }   }
    return true;

}
public void displayLosingMessage()
{
    //your code here
    for(int r=0; r<NUM_ROWS; r++)
    {
         for(int c=0; c<NUM_COLS; c++)
        {
            if(!buttons[r][c].isClicked()&&bombs.contains(buttons[r][c]))
            {
                buttons[r][c].marked=false;
                buttons[r][c].clicked=true;
                buttons[9][6].setLabel("Y");
                buttons[9][7].setLabel("O");
                buttons[9][8].setLabel("U");
                buttons[9][9].setLabel(" ");
                buttons[9][10].setLabel("L");
                buttons[9][11].setLabel("O");
                buttons[9][12].setLabel("S");
                buttons[9][13].setLabel("T");
            }
        }
    }
}
public void displayWinningMessage()
{
    //your code here
buttons[9][6].setLabel("Y");
buttons[9][7].setLabel("O");
buttons[9][8].setLabel("U");
buttons[9][9].setLabel(" ");
buttons[9][10].setLabel("W");
buttons[9][11].setLabel("I");
buttons[9][12].setLabel("N");
buttons[9][13].setLabel("!");
    

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
        if(mouseButton == RIGHT)
        {
            marked=!marked;
        }
        if(mouseButton == LEFT && !marked)
        {

            clicked = true;
            if(bombs.contains(this))
            {
                displayLosingMessage();
            }

            else if(countBombs(r,c)>0)
            {
                label=""+countBombs(r,c);
            }
            else
            {
                if(isValid(r,c-1) && !buttons[r][c-1].isClicked())
                buttons[r][c-1].mousePressed();
                if(isValid(r,c+1) && !buttons[r][c+1].isClicked())
                buttons[r][c+1].mousePressed();
                if(isValid(r-1,c) && !buttons[r-1][c].isClicked())
                buttons[r-1][c].mousePressed();
                if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
                buttons[r+1][c].mousePressed();
                if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked())
                buttons[r-1][c-1].mousePressed();
                if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked())
                buttons[r+1][c+1].mousePressed();
                if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked())
                buttons[r-1][c+1].mousePressed();
                if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked())
                buttons[r+1][c-1].mousePressed();
            }
        }    


/*        
        System.out.println("mousePressed["+r+"]["+c+"](start) marked="+str(marked)+", clicked="+str(clicked) + ", label ={" + label + "}");

        clicked = true;
        //your code here
        if (keyPressed)
        {
            System.out.println("mousePressed["+r+"]["+c+"](mid) keyPressed");

            marked =! marked;
            if (!marked)
            {
                clicked = false;
            }
        }
        else if (bombs.contains(this)) 
        {
            System.out.println("mousePressed["+r+"]["+c+"](mid) bombs.contains(this)=true");

            displayLosingMessage();
        }
        else if (countBombs(this.r, this.c)>0) 
        {
            label = str(countBombs(this.r, this.c));

            System.out.println("mousePressed["+r+"]["+c+"](mid) countBombs=" + label);

        }
        else // no bombs in neighboring buttons
        {
            System.out.println("mousePressed["+r+"]["+c+"](mid) no bombs");

            if( isValid(r-1,c-1) ) buttons[r-1][c-1].mousePressed();
            if( isValid(r,c-1) ) buttons[r][c-1].mousePressed();
            if( isValid(r+1,c-1) ) buttons[r+1][c-1].mousePressed();
            if( isValid(r-1,c) ) buttons[r-1][c].mousePressed();
            if( isValid(r+1,c) ) buttons[r+1][c].mousePressed();
            if( isValid(r-1,c+1) ) buttons[r-1][c+1].mousePressed();
            if( isValid(r,c+1) ) buttons[r][c+1].mousePressed();
            if( isValid(r+1,c+1) ) buttons[r+1][c+1].mousePressed();
/*
            buttons[r-1][c-1].mousePressed();
            buttons[r][c-1].mousePressed();
            buttons[r+1][c-1].mousePressed();
            buttons[r-1][c].mousePressed();
            buttons[r+1][c].mousePressed();
            buttons[r-1][c+1].mousePressed();
            buttons[r][c+1].mousePressed();
            buttons[r+1][c+1].mousePressed();
        }
*/
        
        //System.out.println("mousePressed["+r+"]["+c+"](end) marked="+str(marked)+", clicked="+str(clicked) + ", label ={" + label + "}");
        
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
//        System.out.print("isValid["+r+"]["+c+"]");

//        if (r<20 && c<20) 
        if (r<20 && c<20 && r>=0 && c>=0) 
        {
//        System.out.print("true");
            return true;
        }
        
//        System.out.print("true");
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
        //System.out.print("countBombs[" + row + "][" + col + "] ");
        for ( int i=row-1; i<=row+1; i++ )
            for ( int j=col-1; j<=col+1; j++ )
            {
                if( (i==row) && (j==col) )
                {
                    // do nothing
                }
                else
                {
        //System.out.print("(" + i + "," + j + ")");
//                    if(buttons[i][j].isValid(i,j) && bombs.contains(buttons[i][j]))
                    if(isValid(i,j) && bombs.contains(buttons[i][j]))
                    {
                        numBombs++;
                    }
                }
            }
        
//        System.out.println("countBombs[" + row + "][" + col + "] = " + numBombs);
        //System.out.println(" = " + numBombs);
        return numBombs;
    }
}



