## [Tutorial: Tic-Tac-Toe](https://react.dev/learn/tutorial-tic-tac-toe)
- You will build a small tic-tac-toe game during this tutorial.
    - This tutorial does not assume any existing React knowledge.
    - The techniques you’ll learn in the tutorial are fundamental to building any React app, and fully understanding it will give you a deep understanding of React.
- The tutorial is divided into several sections:
    - [Setup for the tutorial](#setup-for-the-tutorial) will give you a starting point to follow the tutorial.
    - [Overview](#overview) will teach you the fundamentals of React: components, props, and state.
    - [Completing the game](#completing-the-game) will teach you the most common techniques in React development.
    - [Adding time travel](#adding-time-travel) will give you a deeper insight into the unique strengths of React.

### Table of Contents
1. [What are you building?](#what-are-you-building)
2. [Setup for the tutorial](#setup-for-the-tutorial)
3. [Overview](#overview)
    - [Inspecting the Starter Code](#inspecting-the-starter-code)
        - [App.js](#appjs)
        - [style.css](#stylecss)
        - [index.js](#indexjs)
    - [Building the board](#building-the-board)
    - [Passing data through props](#passing-data-through-props)
    - [Making an interactive component](#making-an-interactive-component)

### What are you building?
- In this tutorial, you’ll build an interactive tic-tac-toe game with React.
- You can see what it will look like when you’re finished here:
    ```js
    //App.js
    import { useState } from 'react';

    function Square({ value, onSquareClick }) {
        return (
            <button className="square" onClick={onSquareClick}>
                {value}
            </button>
        );
    }

    function Board({ xIsNext, squares, onPlay }) {
        function handleClick(i) {
            if (calculateWinner(squares) || squares[i]) {
                return;
            }
            const nextSquares = squares.slice();
            if (xIsNext) {
                nextSquares[i] = 'X';
            } else {
                nextSquares[i] = 'O';
            }
            onPlay(nextSquares);
        }

        const winner = calculateWinner(squares);
        let status;
        if (winner) {
            status = 'Winner: ' + winner;
        } else {
            status = 'Next player: ' + (xIsNext ? 'X' : 'O');
        }

        return (
            <>
                <div className="status">{status}</div>
                <div className="board-row">
                    <Square value={squares[0]} onSquareClick={() => handleClick(0)} />
                    <Square value={squares[1]} onSquareClick={() => handleClick(1)} />
                    <Square value={squares[2]} onSquareClick={() => handleClick(2)} />
                </div>
                <div className="board-row">
                    <Square value={squares[3]} onSquareClick={() => handleClick(3)} />
                    <Square value={squares[4]} onSquareClick={() => handleClick(4)} />
                    <Square value={squares[5]} onSquareClick={() => handleClick(5)} />
                </div>
                <div className="board-row">
                    <Square value={squares[6]} onSquareClick={() => handleClick(6)} />
                    <Square value={squares[7]} onSquareClick={() => handleClick(7)} />
                    <Square value={squares[8]} onSquareClick={() => handleClick(8)} />
                </div>
            </>
        );
    }

    export default function Game() {
        const [history, setHistory] = useState([Array(9).fill(null)]);
        const [currentMove, setCurrentMove] = useState(0);
        const xIsNext = currentMove % 2 === 0;
        const currentSquares = history[currentMove];

        function handlePlay(nextSquares) {
            const nextHistory = [...history.slice(0, currentMove + 1), nextSquares];
            setHistory(nextHistory);
            setCurrentMove(nextHistory.length - 1);
        }

        function jumpTo(nextMove) {
            setCurrentMove(nextMove);
        }

        const moves = history.map((squares, move) => {
            let description;
            if (move > 0) {
                description = 'Go to move #' + move;
            } else {
                description = 'Go to game start';
            }
            return (
                <li key={move}>
                    <button onClick={() => jumpTo(move)}>{description}</button>
                </li>
            );
        });

        return (
            <div className="game">
            <div className="game-board">
                <Board xIsNext={xIsNext} squares={currentSquares} onPlay={handlePlay} />
            </div>
            <div className="game-info">
                <ol>{moves}</ol>
            </div>
            </div>
        );
    }

    function calculateWinner(squares) {
        const lines = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8],
            [0, 4, 8],
            [2, 4, 6],
        ];
        for (let i = 0; i < lines.length; i++) {
            const [a, b, c] = lines[i];
            if (squares[a] && squares[a] === squares[b] && squares[a] === squares[c]) {
            return squares[a];
            }
        }
        return null;
    }
    ```
- If the code doesn’t make sense to you yet, or if you are unfamiliar with the code’s syntax, don’t worry!
    - The goal of this tutorial is to help you understand React and its syntax.
- We recommend that you check out the tic-tac-toe game above before continuing with the tutorial.
    - One of the features that you’ll notice is that there is a numbered list to the right of the game’s board.
    - This list gives you a history of all of the moves that have occurred in the game, and it is updated as the game progresses.
- Once you’ve played around with the finished tic-tac-toe game, keep scrolling.
    - You’ll start with a simpler template in this tutorial. Our next step is to set you up so that you can start building the game.

### Setup for the tutorial
```js
//App.js
export default function Square() {
  return <button className="square">X</button>;
}
```

### Overview
- Now that you’re set up, let’s get an overview of React!

#### Inspecting the starter code
- The Files section with a list of files like ``App.js``, ``index.js``, ``styles.css`` and a folder called ``public``
##### App.js
- The code in App.js creates a component.
    - In React, a component is a piece of reusable code that represents a part of a user interface.
    - Components are used to render, manage, and update the UI elements in your application.
    - Let’s look at the component line by line to see what’s going on:
        ```js
        export default function Square() {
            return <button className="square">X</button>;
        }
        ```
        - The first line defines a function called ``Square``.
        - The ``export`` JavaScript keyword makes this function accessible outside of this file.
        - The ``default`` keyword tells other files using your code that it’s the main function in your file.
        ```js
        return <button className="square">X</button>;
        ```
        - The second line returns a button.
        - The ``return`` JavaScript keyword means whatever comes after is returned as a value to the caller of the function.
        - ``<button>`` is a JSX element.
        - A JSX element is a combination of JavaScript code and HTML tags that describes what you’d like to display.
        - ``className="square"`` is a button property or prop that tells CSS how to style the button.
        - ``X`` is the text displayed inside of the button and ``</button>`` closes the JSX element to indicate that any following content shouldn’t be placed inside the button.
##### styles.css
- This file defines the styles for your React app.
    - The first two CSS selectors (* and body) define the style of large parts of your app while the .square selector defines the style of any component where the className property is set to square.
    - In your code, that would match the button from your Square component in the App.js file.
##### index.js
- You won’t be editing this file during the tutorial but it is the bridge between the component you created in the ``App.js`` file and the web browser.
    ```js
    import {StrictMode} from 'react';
    import {createRoot} from 'react-dom/client';
    import './styles.css';

    import App from './App';
    ```
    - Lines 1-5 brings all the necessary pieces together:
        - React
        - React’s library to talk to web browsers (React DOM)
        - the styles for your components
        - the component you created in ``App.js``.
    - The remainder of the file brings all the pieces together and injects the final product into ``index.html`` in the ``public`` folder.

#### Building the board
- Let’s get back to App.js. This is where you’ll spend the rest of the tutorial.
- Currently the board is only a single square, but you need nine!
- If you just try and copy paste your square to make two squares like this:
    ```js
    export default function Square() {
        return <button className="square">X</button><button className="square">X</button>;
    }
    ```
- You’ll get this error:
    ```bash
    /src/App.js: Adjacent JSX elements must be wrapped in an enclosing tag. Did you want a JSX fragment <>...</>?
    ```
- React components need to return a single JSX element and not multiple adjacent JSX elements like two buttons.
- To fix this you can use fragments (<> and </>) to wrap multiple adjacent JSX elements like this:
    ```js
    export default function Square() {
        return (
            <>
            <button className="square">X</button>
            <button className="square">X</button>
            </>
        );
    }
    ```
- Now you should see:
    ![image](https://react.dev/images/tutorial/two-x-filled-squares.png)
- Great! Now you just need to copy-paste a few times to add nine squares and…
    ![image](https://react.dev/images/tutorial/nine-x-filled-squares.png)
- Oh no! The squares are all in a single line, not in a grid like you need for our board.
    - To fix this you’ll need to group your squares into rows with divs and add some CSS classes.
    - While you’re at it, you’ll give each square a number to make sure you know where each square is displayed.
- In the App.js file, update the Square component to look like this:
    ```js
    export default function Square() {
        return (
            <>
            <div className="board-row">
                <button className="square">1</button>
                <button className="square">2</button>
                <button className="square">3</button>
            </div>
            <div className="board-row">
                <button className="square">4</button>
                <button className="square">5</button>
                <button className="square">6</button>
            </div>
            <div className="board-row">
                <button className="square">7</button>
                <button className="square">8</button>
                <button className="square">9</button>
            </div>
            </>
        );
    }
    ```
- The CSS defined in styles.css styles the divs with the className of board-row.
    - Now that you’ve grouped your components into rows with the styled divs you have your tic-tac-toe board:
    ![image](https://react.dev/images/tutorial/number-filled-board.png)
- But you now have a problem. Your component named Square, really isn’t a square anymore. Let’s fix that by changing the name to ``Board``:
    ```js
    export default function Board() {
    //...
    }
    ```
#### Passing data through props
- Next, you’ll want to change the value of a square from empty to “X” when the user clicks on the square.
    - With how you’ve built the board so far you would need to copy-paste the code that updates the square nine times (once for each square you have)!
    - Instead of copy-pasting, React’s component architecture allows you to create a reusable component to avoid messy, duplicated code.
- First, you are going to copy the line defining your first square (``<button className="square">1</button>``) from your Board component into a new Square component:
    ```js
    function Square() {
        return <button className="square">1</button>;
    }

    export default function Board() {
    // ...
    }
- Then you’ll update the Board component to render that ``Square`` component using JSX syntax:
    ```js
    // ...
    export default function Board() {
        return (
            <>
            <div className="board-row">
                <Square />
                <Square />
                <Square />
            </div>
            <div className="board-row">
                <Square />
                <Square />
                <Square />
            </div>
            <div className="board-row">
                <Square />
                <Square />
                <Square />
            </div>
            </>
        );
    }
    ```
- Note how unlike the browser divs, your own components Board and Square must start with a capital letter.
- Let’s take a look:
    ![image](https://react.dev/images/tutorial/board-filled-with-ones.png)
    - Oh no! You lost the numbered squares you had before.
    - Now each square says “1”.
    - To fix this, you will use props to pass the value each square should have from the parent component (Board) to its child (Square).
- Update the ``Square`` component to read the ``value`` prop that you’ll pass from the ``Board``:
    ```js
    function Square({ value }) {
        return <button className="square">1</button>;
    }
    ```
    - ``function Square({ value })`` indicates the Square component can be passed a prop called value.
- Now you want to display that ``value`` instead of ``1`` inside every square. Try doing it like this:
    ```js
    function Square({ value }) {
        return <button className="square">value</button>;
    }
    ```
- Oops, this is not what you wanted:
    ![image](https://react.dev/images/tutorial/board-filled-with-value.png)
- You wanted to render the JavaScript variable called value from your component, not the word “value”.
    - To “escape into JavaScript” from JSX, you need curly braces. Add curly braces around value in JSX like so:
    ```js
    function Square({ value }) {
        return <button className="square">{value}</button>;
    }
    ```
- For now, you should see an empty board:
    ![image](https://react.dev/images/tutorial/empty-board.png)
- This is because the Board component hasn’t passed the value prop to each Square component it renders yet.
- To fix it you’ll add the value prop to each Square component rendered by the Board component:
    ```js
    export default function Board() {
        return (
            <>
            <div className="board-row">
                <Square value="1" />
                <Square value="2" />
                <Square value="3" />
            </div>
            <div className="board-row">
                <Square value="4" />
                <Square value="5" />
                <Square value="6" />
            </div>
            <div className="board-row">
                <Square value="7" />
                <Square value="8" />
                <Square value="9" />
            </div>
            </>
        );
    }
    ```
- Now you should see a grid of numbers again:
    ![image](https://react.dev/images/tutorial/number-filled-board.png)

#### Making an interactive component