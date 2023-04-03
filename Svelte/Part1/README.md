## [Introduction](https://learn.svelte.dev/tutorial/welcome-to-svelte)

### Welcome to Svelte
#### What is Svelte?
- Svelte is a tool for building web applications. 
    - Like other user interface frameworks, it allows you to build your app declaratively out of components that combine markup, styles and behaviours.
- These components are compiled into small, efficient JavaScript modules that eliminate overhead traditionally associated with UI frameworks.
- You can build your entire app with Svelte (for example, using an application framework like [SvelteKit](https://kit.svelte.dev/), which this tutorial will cover), or you can add it incrementally to an existing codebase. 
    - You can also ship components as standalone packages that work anywhere.

### Your first component
- In Svelte, an application is composed from one or more components. 
    - A component is a reusable self-contained block of code that encapsulates HTML, CSS and JavaScript that belong together, written into a .svelte file. 
    - The App.svelte file, open in the code editor to the right, is a simple component.
#### Adding data
- A component that just renders some static markup isn't very interesting. Let's add some data.
- First, add a script tag to your component and declare a name variable:
    ```js
    <script>
        let name = 'Svelte';
    </script>

    <h1>Hello world!</h1>
    ```
- Then, we can refer to name in the markup:
    ```js
    <h1>Hello {name}!</h1>
    ```
- Inside the curly braces, we can put any JavaScript we want. Try changing name to name.toUpperCase() for a shoutier greeting.
    ```js
    <h1>Hello {name.toUpperCase()}!</h1>
    ```
### Dynamic attributes
- Just like you can use curly braces to control text, you can use them to control element attributes.
- Our image is missing a src - let's add one:
    ```js
    <img src={src} />
    ```
- That's better. But if you hover over the ``<img>`` in the editor, Svelte is giving us a warning:
    > A11y: ``<img>`` element should have an alt attribute
- When building web apps, it's important to make sure that they're accessible to the broadest possible userbase, including people with (for example) impaired vision or motion, or people without powerful hardware or good internet connections. 
    - Accessibility (shortened to a11y) isn't always easy to get right, but Svelte will help by warning you if you write inaccessible markup.
- In this case, we're missing the alt attribute that describes the image for people using screenreaders, or people with slow or flaky internet connections that can't download the image. Let's add one:
    ```js
    <img src={src} alt="A man dances." />
    ```
- We can use curly braces inside attributes. Try changing it to "{name} dances." - remember to declare a name variable in the ``<script>`` block.

#### Shorthand attributes
- It's not uncommon to have an attribute where the name and value are the same, like src={src}. 
    - Svelte gives us a convenient shorthand for these cases:
    ```js
    <img {src} alt="A man dances." />
    ```

### Styling
- Just like in HTML, you can add a ``<style>`` tag to your component. Let's add some styles to the ``<p>`` element:
    ```js
    <p>This is a paragraph.</p>

    <style>
        p {
            color: goldenrod;
            font-family: 'Comic Sans MS', cursive;
            font-size: 2em;
        }
    </style>
    ```
- Importantly, these rules are scoped to the component.
    - You won't accidentally change the style of ``<p>`` elements elsewhere in your app, as we'll see in the next step.

### Nested components
- It would be impractical to put your entire app in a single component.
    - Instead, we can import components from other files and include them in our markup.
- Add a ``<script>`` tag to the top of App.svelte that imports Nested.svelte...
    ```js
    <script>
        import Nested from './Nested.svelte';
    </script>
    ```
- ...and include a ``<Nested />`` component:
    ```js
    <p>This is a paragraph.</p>
    <Nested />
    ```
- Notice that even though Nested.svelte has a ``<p>`` element, the styles from App.svelte don't leak in.
- Component names are always capitalised, to distinguish them from HTML elements.

    ```js
    // App.svelte
    <script>
        import Nested from './Nested.svelte';
    </script>

    <p>This is a paragraph.</p>
    <Nested />

    <style>
        p {
            color: goldenrod;
            font-family: 'Comic Sans MS', cursive;
            font-size: 2em;
        }
    </style>

    // Nested.svelte
    <p>This is another paragraph.</p>
    ```

## [Reactivity](https://learn.svelte.dev/tutorial/reactive-assignments)

### Assignments
- At the heart of Svelte is a powerful system of reactivity for keeping the DOM in sync with your application state - for example, in response to an event.
- To demonstrate it, we first need to wire up an event handler (we'll learn more about these [later](https://learn.svelte.dev/tutorial/dom-events):
    ```js
    <button on:click={increment}>
        Clicked {count}
        {count === 1 ? 'time' : 'times'}
    </button>
    ```
- Inside the ``increment`` function, all we need to do is change the value of ``count``:
    ```js
    function increment() {
        count += 1;
    }
    ```
- Svelte 'instruments' this assignment with some code that tells it the DOM will need to be updated.

    ```js
    // App.svelte
    <script>
        let count = 0;

        function increment() {
            count += 1;
        }
    </script>

    <button on:click={increment}>
        Clicked {count}
        {count === 1 ? 'time' : 'times'}
    </button>
    ```

### Declarations
- Svelte automatically updates the DOM when your component's state changes.
    - Often, some parts of a component's state need to be computed from other parts (such as a ``fullname`` derived from a ``firstname`` and a ``lastname``), and recomputed whenever they change.
- For these, we have reactive declarations. They look like this:
    ```js
    let count = 0;
    $: doubled = count * 2;
    ```
> Don't worry if this looks a little alien. It's [valid](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/label) (if unconventional) JavaScript, which Svelte interprets to mean 're-run this code whenever any of the referenced values change'. Once you get used to it, there's no going back.
- Let's use doubled in our markup:
    ```js
    <button>...</button>

    <p>{count} doubled is {doubled}</p>
    ```
- Of course, you could just write {count * 2} in the markup instead - you don't have to use reactive values.
    - Reactive values become particularly valuable (no pun intended) when you need to reference them multiple times, or you have values that depend on *other* reactive values.

    ```js
    // App.svelte
    <script>
        let count = 0;
        $: doubled = count * 2;

        function increment() {
            count += 1;
        }
    </script>

    <button on:click={increment}>
        Clicked {count}
        {count === 1 ? 'time' : 'times'}
    </button>

    <p>{count} doubled is {doubled}</p>
    ```

### Statements
- We're not limited to declaring reactive values - we can also run arbitrary statements reactively.
    - For example, we can log the value of count whenever it changes:
    ```js
    let count = 0;

    $: console.log(`the count is ${count}`);
    ```
- You can easily group statements together with a block:
    ```js
    $: {
        console.log(`the count is ${count}`);
        console.log(`this will also be logged whenever count changes`);
    }
    ```
- You can even put the ``$:`` in front of things like ``if`` blocks:
    ```js
    $: if (count >= 10) {
        alert('count is dangerously high!');
        count = 0;
    }
    ```
    ```js
    // App.svelte
    <script>
        let count = 0;

        $: if (count >= 10) {
            alert('count is dangerously high!');
            count = 0;
        }

        function handleClick() {
            count += 1;
        }
    </script>

    <button on:click={handleClick}>
        Clicked {count}
        {count === 1 ? 'time' : 'times'}
    </button>
    ```

### Updating Arrays and Objects
- Because Svelte's reactivity is triggered by assignments, using array methods like ``push`` and ``splice`` won't automatically cause updates.
    - For example, clicking the 'Add a number' button doesn't currently do anything, even though we're calling ``numbers.push(...)`` inside ``addNumber``.
- One way to fix that is to add an assignment that would otherwise be redundant:
    ```js
    function addNumber() {
        numbers.push(numbers.length + 1);
        numbers = numbers;
    }
    ```
- But there's a more idiomatic solution:
    ```js
    function addNumber() {
        numbers = [...numbers, numbers.length + 1];
    }
- You can use similar patterns to replace ``pop``, ``shift``, ``unshift`` and ``splice``.
- Assignments to properties of arrays and objects - e.g. ``obj.foo += 1`` or ``array[i] = x`` - work the same way as assignments to the values themselves.
    ```js
    function addNumber() {
        numbers[numbers.length] = numbers.length + 1;
    }
    ```
- A simple rule of thumb: the name of the updated variable must appear on the left hand side of the assignment. For example this...
    ```js
    const foo = obj.foo;
    foo.bar = 'baz';
    ```
    ...won't trigger reactivity on obj.foo.bar, unless you follow it up with obj = obj.

    ```js
    <script>
        let numbers = [1, 2, 3, 4];

        function addNumber() {
            numbers = [...numbers, numbers.length + 1];
        }

        $: sum = numbers.reduce((t, n) => t + n, 0);
    </script>

    <p>{numbers.join(' + ')} = {sum}</p>

    <button on:click={addNumber}>
        Add a number
    </button>
    ```

## Props

### Declaring props
- So far, we've dealt exclusively with internal state - that is to say, the values are only accessible within a given component.
- In any real application, you'll need to pass data from one component down to its children.
    - To do that, we need to declare properties, generally shortened to 'props'.
    - In Svelte, we do that with the export keyword. Edit the Nested.svelte component:
    ```js
    <script>
	    export let answer;
    </script>
    ```
> Just like ``$:``, this may feel a little weird at first. That's not how ``export`` normally works in JavaScript modules! Just roll with it for now - it'll soon become second nature.

```javascript
// App.svelte
<script>
    import Nested from './Nested.svelte';
</script>

<Nested answer={42} />

// Nested.svelte
<script>
	export let answer;
</script>

<p>The answer is {answer}</p>
```

### Default values
- We can easily specify default values for props in ``Nested.svelte``:
    ```js
    <script>
        export let answer = 'a mystery';
    </script>
    ```
- If we now add a second component without an answer prop, it will fall back to the default:
```js
<Nested answer={42}/>
<Nested />
```

```js
// App.svelte
<script>
    import Nested from './Nested.svelte';
</script>

<Nested answer={42} />
<Nested />

// Nested.svelte
<script>
    export let answer = 'a mystery';
</script>

<p>The answer is {answer}</p>
```

### Spread Props
- In this exercise, we've forgotten to specify the ``version`` prop expected by ``PackageInfo.svelte``, meaning it shows 'version undefined'.
- We could fix it by adding the version prop...
    ```js
    <PackageInfo
        name={pkg.name}
        speed={pkg.speed}
        version={pkg.version}
        website={pkg.website}
    />
    ```
    ...but since the properties of pkg correspond to the component's expected props, we can 'spread' them onto the component instead:
    ```js
    <PackageInfo {...pkg} />
    ```
> Conversely, if you need to reference all the props that were passed into a component, including ones that weren't declared with ``export``, you can do so by accessing ``$$props`` directly. It's not generally recommended, as it's difficult for Svelte to optimise, but it's useful in rare cases.

```js
// App.svelte
<script>
	import PackageInfo from './PackageInfo.svelte';

	const pkg = {
		name: 'svelte',
		speed: 'blazing',
		version: 3,
		website: 'https://svelte.dev'
	};
</script>

<PackageInfo {...pkg} />

// PackageInfo.svelte
<script>
	export let name;
	export let version;
	export let speed;
	export let website;

	$: href = `https://www.npmjs.com/package/${name}`;
</script>

<p>
	The <code>{name}</code> package is {speed} fast. Download version {version} from
	<a {href}>npm</a> and <a href={website}>learn more here</a>
</p>
```

## [Logic](https://learn.svelte.dev/tutorial/if-blocks)

### If blocks
- HTML doesn't have a way of expressing logic, like conditionals and loops. Svelte does.
- To conditionally render some markup, we wrap it in an ``if`` block:
    ```js
    {#if user.loggedIn}
        <button on:click={toggle}>
            Log out
        </button>
    {/if}

    {#if !user.loggedIn}
        <button on:click={toggle}>
            Log in
        </button>
    {/if}
    ```

    ```js
    // App.svelte
    <script>
        let user = { loggedIn: false };

        function toggle() {
            user.loggedIn = !user.loggedIn;
        }
    </script>

    {#if user.loggedIn}
        <button on:click={toggle}>
            Log out
        </button>
    {/if}

    {#if !user.loggedIn}
        <button on:click={toggle}>
            Log in
        </button>
    {/if}
    ```

### Else blocks
- Since the two conditions i ``if user.loggedIn`` and ``if !user.loggedIn`` - are mutually exclusive, we can simplify this component slightly by using an else block:
    ```js
    {#if user.loggedIn}
        <button on:click={toggle}>
            Log out
        </button>
    {:else}
        <button on:click={toggle}>
            Log in
        </button>
    {/if}
    ```
> A ``#`` character always indicates a block opening tag. A ``/`` character always indicates a block closing tag. A ``:`` character, as in ``{:else}``, indicates a block continuation tag. Don't worry - you've already learned almost all the syntax Svelte adds to HTML.

```js
// App.svelte
<script>
    let user = { loggedIn: false };

    function toggle() {
        user.loggedIn = !user.loggedIn;
    }
</script>

{#if user.loggedIn}
    <button on:click={toggle}>
        Log out
    </button>
{:else}
    <button on:click={toggle}>
        Log in
    </button>
{/if}
```

### Else if blocks
- Multiple conditions can be 'chained' together with else if:
    ```js
    {#if x > 10}
        <p>{x} is greater than 10</p>
    {:else if x < 5}
        <p>{x} is less than 5</p>
    {:else}
        <p>{x} is between 5 and 10</p>
    {/if}
    ```
    ```js
    // App.svelte
    <script>
        let x = 0;
    </script>

    <button on:click={() => x += 1}>+1</button>

    {#if x > 10}
        <p>{x} is greater than 10</p>
    {:else if x < 5}
        <p>{x} is less than 5</p>
    {:else}
        <p>{x} is between 5 and 10</p>
    {/if}
    ```

### Each blocks
- When building user interfaces you'll often find yourself working with lists of data.
    - In this exercise, we've repeated the ``<button>`` markup multiple times - changing the colour each time - but there's still more to add.
- Instead of laboriously copying, pasting and editing, we can get rid of all but the first button, then use an each block:
    ```js
    <div>
        {#each colors as color}
            <button
                aria-current="{selected === 'red' ? 'true' : undefined}"
                aria-label="red"
                style="background: red"
                on:click={() => selected = 'red'}
            ></button>
        {/each}
    </div>
    ```

> The expression (``colors``, in this case) can be any array or array-like object (i.e. it has a ``length`` property). You can loop over generic iterables with ``each [...iterable]``.
- Now we need to use the ``color`` variable in place of ``"red"``:
    ```js
    <div>
        {#each colors as color}
            <button
                aria-current="{selected === color ? 'true' : undefined}"
                aria-label={color}
                style="background: {color}"
                on:click={() => selected = color}
            ></button>
        {/each}
    </div>
    ```
- You can get the current index as a second argument, like so:
    ```js
    <div>
        {#each colors as color, i}
            <button
                aria-current="{selected === color ? 'true' : undefined}"
                aria-label={color}
                style="background: {color}"
                on:click={() => selected = color}
            >{i + 1}</button>
        {/each}
    </div>
    ```
    ```js
    // App.svelte
    <script>
        const colors = ['red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet'];
        let selected = colors[0];
    </script>

    <h1 style="color: {selected}">Pick a colour</h1>

    <div>
        {#each colors as color, i}
            <button
                aria-current="{selected === color ? 'true' : undefined}"
                aria-label={color}
                style="background: {color}"
                on:click={() => selected = color}
            >{i + 1}</button>
        {/each}
    </div>

    <style>
        h1 {
            transition: color 0.2s;
        }

        div {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            grid-gap: 5px;
            max-width: 400px;
        }

        button {
            aspect-ratio: 1;
            border-radius: 50%;
            background: var(--color, #fff);
            transform: translate(-2px,-2px);
            filter: drop-shadow(2px 2px 3px rgba(0,0,0,0.2));
            transition: all 0.1s;
        }

        button[aria-current="true"] {
            transform: none;
            filter: none;
            box-shadow: inset 3px 3px 4px rgba(0,0,0,0.2);
        }
    </style>
    ```

### Keyed each blocks
- By default, when you modify the value of an ``each`` block, it will add and remove items at the end of the block, and update any values that have changed.
    - That might not be what you want.
- It's easier to show why than to explain.
    - Click the 'Remove first thing' button a few times, and notice what happens: It removes the first ``<Thing>`` component, but the last DOM node.
    - Then it updates the name value in the remaining DOM nodes, but not the emoji, which in Thing.svelte is fixed when the component is created.
- Instead, we'd like to remove only the first ``<Thing>`` component and its DOM node, and leave the others unaffected.
- To do that, we specify a unique identifier (or "key") for the ``each`` block:
    ```js
    {#each things as thing (thing.id)}
        <Thing name={thing.name}/>
    {/each}
    ```
- Here, ``(thing.id)`` is the key, which tells Svelte how to figure out which DOM node to change when the component updates.
> You can use any object as the key, as Svelte uses a ``Map`` internally - in other words you could do ``(thing)`` instead of ``(thing.id)``. Using a string or number is generally safer, however, since it means identity persists without referential equality, for example when updating with fresh data from an API server.

```js
// App.svelte
<script>
    import Thing from './Thing.svelte';

    let things = [
        { id: 1, name: 'apple' },
        { id: 2, name: 'banana' },
        { id: 3, name: 'carrot' },
        { id: 4, name: 'doughnut' },
        { id: 5, name: 'egg' }
    ];

    function handleClick() {
        things = things.slice(1);
    }
</script>

<button on:click={handleClick}>
    Remove first thing
</button>

{#each things as thing (thing.id)}
    <Thing name={thing.name} />
{/each}

// Thing.svelte
<script>
    const emojis = {
        apple: '🍎',
        banana: '🍌',
        carrot: '🥕',
        doughnut: '🍩',
        egg: '🥚'
    };

    // the name is updated whenever the prop value changes...
    export let name;

    // ...but the "emoji" variable is fixed upon initialisation
    // of the component because it uses `const` instead of `$:`
    const emoji = emojis[name];
</script>

<p>{emoji} = {name}</p>
```
### Await blocks
- Most web applications have to deal with asynchronous data at some point.
    - Svelte makes it easy to await the value of promises directly in your markup:
    ```js
    {#await promise}
        <p>...waiting</p>
    {:then number}
        <p>The number is {number}</p>
    {:catch error}
        <p style="color: red">{error.message}</p>
    {/await}
    ```
> Only the most recent ``promise`` is considered, meaning you don't need to worry about race conditions.
- If you know that your promise can't reject, you can omit the ``catch`` block. You can also omit the first block if you don't want to show anything until the promise resolves:
    ```js
    {#await promise then number}
        <p>The number is {number}</p>
    {/await}
    ```
    ```js
    // App.svelte
    <script>
        import { getRandomNumber } from './utils.js';

        let promise = getRandomNumber();

        function handleClick() {
            promise = getRandomNumber();
        }
    </script>

    <button on:click={handleClick}>
        generate random number
    </button>

    {#await promise then number}
        <p>The number is {number}</p>
    {/await}

    // utils.js
    export async function getRandomNumber() {
        // Fetch a random number between 0 and 100
        // (with a delay, so that we can see it)
        const res = await fetch('/random-number');

        if (res.ok) {
            return await res.text();
        } else {
            // Sometimes the API will fail!
            throw new Error('Request failed');
        }
    }
    ```