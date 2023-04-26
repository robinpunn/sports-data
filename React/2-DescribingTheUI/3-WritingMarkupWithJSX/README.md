## Writing Markup with JSX
- JSX is a syntax extension for JavaScript that lets you write HTML-like markup inside a JavaScript file.
    - Although there are other ways to write components, most React developers prefer the conciseness of JSX, and most codebases use it.

- You will learn
    - Why React mixes markup with rendering logic
    - How JSX is different from HTML
    - How to display information with JSX

---
### Table of Contents
1. [JSX: Putting markup into JavaScript](#jsx-putting-markup-into-javascript)
1. [Converting HTML to JSX](#converting-html-to-jsx)
---


### JSX: Putting markup into JavaScript
- The Web has been built on HTML, CSS, and JavaScript.
    - For many years, web developers kept content in HTML, design in CSS, and logic in JavaScript - often in separate files!
    - Content was marked up inside HTML while the page’s logic lived separately in JavaScript:
    ```html
    <div>
        <p></p>
        <form></form>
    </div>
    ```
    ```js
    isLoggedIn() {...}
    onClick() {...}
    onSubmite() {...}
    ```
- But as the Web became more interactive, logic increasingly determined content.
    - JavaScript was in charge of the HTML!
    - This is why in React, rendering logic and markup live together in the same place - components.
    ```js
    // Sidebar.js
    Sidebar() {
        if (isLoggedIn()) {
            <p>Welcome</p>
        } else {
            <Form/>
        }
    }

    // Form.js
    Form() {
        onClick() {...}
        onSubmit() {...}
        <form onSubmit>
            <input onClick />
            <input onClick />
        </form>
    }
    ```
- Keeping a button’s rendering logic and markup together ensures that they stay in sync with each other on every edit.
    - Conversely, details that are unrelated, such as the button’s markup and a sidebar’s markup, are isolated from each other, making it safer to change either of them on their own.
- Each React component is a JavaScript function that may contain some markup that React renders into the browser.
    - React components use a syntax extension called JSX to represent that markup.
    - JSX looks a lot like HTML, but it is a bit stricter and can display dynamic information.
    - The best way to understand this is to convert some HTML markup to JSX markup.
> NOTE
> JSX and React are two separate things. They’re often used together, but you can [use them independently](https://reactjs.org/blog/2020/09/22/introducing-the-new-jsx-transform.html#whats-a-jsx-transform) of each other. JSX is a syntax extension, while React is a JavaScript library.

### Converting HTML to JSX