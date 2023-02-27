# Junior to Senior Web Developer Roadmap

### SSH
1. Introduction to SSH
    - Secure Shell (SSH) is a protocol
        - HTTP is a protocol that allows you to send and receive data over the internet
        - FTP (file transfer protocol) is a protocol that allows you to transfer files over the internet
        - HTTPS is similar to HTTP but it is encrypted
        - SSH allows two computers to communicate securely over an unsecured network
    - SSH allows users to connect to a remote computer and execute commands on it
    - A shell is a program that allows you to interact with the operating system as opposed to a browser which is a program that allows you to interact with the internet
    - The significant advantage of SSH over its predecessors is the use of encryption to secure the communication between host and client
        - Host = remote server being accessed
        - Client = computer that is accessing the remote server
2. SSH Command
    - `ssh [username]@[host]`
    - Easy to use with linux and mac, windows requires a third party program
    - the `ssh` command instructs the computer to open a secure shell connection
    - `[user]` represents the account to be accessed
    - `[host]` represents the remote server to be accessed
3. How SSH Works
    - There are three techniques used in SSH
        - Symmetrical Encryption
        - Asymmetrical Encryption
        - Hashing
4. Symmetric Encyption
    - Symmetric encryption uses the same key to encrypt and decrypt data
    - Key exchange algorithm is used to exchange the key between the client and the server
        - The key is never transmitted over the network
        - Secret key is specific to each session
        - Generated prior to client and server authentication
5. Asymmetric Encryption
    - Uses two keys, a public key and a private key
    - The public key is used to encrypt data and the private key is used to decrypt data
    - Only used during the key exchange process
    - Diffie-Hellman key exchange algorithm is used to exchange the keys
6. Hashing
    - SSH uses both symmetric and asymmetric encryption
        - Assymetric is used to share the symmetric key
        - Key is used by the symmetric encryption
        - The host server creates a message that is encrypted with the public key to prove its identity
    - Hashing solves the man-in-the-middle-problem
        - Hashing is a one-way function
    - Hashes verify the authenticity of the message
        - HMAC (Hash-based Message Authentication Code) is used to verify the integrity of the message
            - Each message transmitted must contain a message authentication code
7. Passwords or SSH?
    - Two ways to authenticate when using SSH
        - Password
        - Public Key
8. SSH into a sever
    - RSA keys are used to authenticate
    - RSA keys are a pair of keys, a public key and a private key
    - The public key is used to encrypt data and the private key is used to decrypt data
    - The private key is never shared
    - The public key is shared with the server
    - The server uses the public key to encrypt a message
    - The client uses the private key to decrypt the message
    - The client then uses the public key to encrypt a message
    - The server uses the private key to decrypt the message
9. Summary
    1. Diffie-Hellman key exchange algorithm is used to exchange the keys
    2. Arrive at a symmetric key
    3. Hashing is used to verify there is no tampering
    4. User is authenticated
        - use password
        - use rsa keys

### Performance Part 1
1. Introduction to Performance Part 1
    - Client + Server relationship
        - Client = browser
        - Server = computer that is serving the website
    - HTML file gives indication of what files are needed from the server
    - Browser requests the files from the server
    - Server sends the files to the browser
    - Browser renders the files
2. Keys to performance
    - Three ways to improve performance
        - Front-end rendering
        - Transfer of files
        - Back-end processing
    - Front-end
        - Critical rendering path
            - HTML -> CSS -> JS
            - Optimized code
            - Progressive web apps
    - Transfer of files
        - Minimize files
        - Minimize delivery
    - Back-end
        - CDNs
        - Caching
        - Load balancing
        - DB scaling
        - Gzip
3. Network Performance
    - Reduce size of files
        - Minimize text and optimize images
4. Image file and formats
    - The best way to reduce the size of an image is by choosing the right format
    - The most common image formats are
        - JPEG
        - PNG
        - GIF
        - SVG
    - JPEG (joint photographic experts group)
        - use for images with many colors
        - use for photos
        - can't have transparency
        - larger file size
    - GIF (graphics interchange format)
        - use for images with few colors
        - small animations
        - can have transparency
        - smaller file size
    - PNG (portable network graphics)
        - limit the number of colors
        - good for logos
        - can have transparency
        - smaller file size
    - SVG (scalable vector graphics)
        - image can be expanded or reduced without losing quality
        - use for logos, simplistic images
        - can have transparency
        - smaller file size
    - Pick the right format and compress the image without losing quality
5. Image Optimizations
    - Minimize Images
    - If you want transparency: use PNG
    - If you want animation: use GIF
    - If you want quality: use JPEG
    - If you want simple icons, logos, and illustrations: use SVG
    - Reduce PNG with PNGQuant, PNGCrush, PNGOut, TinyPNG
    - Reduce JPEG with JPEGMini, JPEGTran, TinyJPG, JPEG-Optimizer
    - Try to use simple illustrations over highly detailed images
    - Always lower jpeg quality (30-60%)... the larger the resolution, the larger the file size
    - Resize images to the size they will be displayed
    - Display different sized images for different backgrounds (media queries)
    - Use CDNs like imgix, cloudinary, and fastly
    - Remove image metadata
    - [View and Remove Exif Online](https://www.verexif.com/en/)
    - [Media Queries](https://css-tricks.com/snippets/css/media-queries-for-standard-devices/)
    - [Media Query Cheat Sheet](https://gist.github.com/bartholomej/8415655)
6. Delivery Optimizations
    - Reducing frequency
    - Reducing the amount of files that need to be retrieved
    - [Max Parallel Requests Per Browser](https://stackoverflow.com/questions/985431/max-parallel-http-connections-in-a-browser)
        - Chrome: 6
        - Firefox: 6
        - Safari: 6
        - IE: 2
        - Opera: 4
7. Critical Render Path Introduction
    - Critical Render Path
        1. Client requests site and server returns HTML file
        2. HTML file is parsed and DOM(document object model) tree is created
            - DOM describes the structure of the page
        3. CSS files are requested and parsed
            - CSSOM (CSS object model) is created
        4. JS files are requested and parsed
            - JS executes any changes to the DOM and CSSOM
        5. Render tree is created which is a combination of the DOM and CSSOM
        6. Render tree is used to create the visual representation of the page
        7. Images are not part of the critical render path
    - DOM -> CSSOM -> (DOM content loaded) Render Tree -> Layout -> Paint (Load)
8. Critical Render Path Part 1
    - Try to load CSS as soon as possible
    - Try to load JS as late as possible with a few exceptions
        - JS that is needed to render the page
        - JS that is needed to render the page quickly
        - JS that is needed to render the page correctly
    - JS requires HTML and CSS parsing before it can run
    - HTML
        - Load style sheets in the head
        - Load scripts at the bottom of the body
9. Critical Render Path Part 2
    - CSS is render blocking
        - CSS needs to complete before the page can be rendered
    - Try to make CSS as small as possible so the user can see the page as soon as possible
    -CSS
        - Only load whatever is needed
        - Above the fold loading
        - Media attributes
        - Less specificity
10. Critical Render Path 3
    - JavaScript is exectucuted after the DOM and CSSOM are created
    - JavaScript can access and modify the DOM and CSSOM
    - JavaScript is parser blocking
        - JavaScript needs to complete before the page can be rendered
    - JS
        - Load scripts asynchronously
        - Defer loading scripts
        - Minimize DOM manipulation
        - Avoid long running scripts
    - Async and Defer can be used to load files that are non-essential to user experience
        - The difference between async and defer is that async will load the file as soon as possible and defer will load the file after the DOM is created
        - If core functionality of the page is dependent on the file, use async
        - [Script Tag - async and defer](https://stackoverflow.com/questions/10808109/script-tag-async-defer)
11. Critical Render Path 4
    - Render Tree is created from the DOM and CSSOM
    - Browser uses the render tree to create the visual representation of the page
    - The browser paints the page
    - The browser loads the page
    - JavaScript can cause a new rendering by changing the DOM or CSSOM
12. HTTP/2
    - Protocol update to improve network latency
    - Bundling may not have the same effect with HTTP/2 because of multiplexing
        - Multiplexing allows multiple requests to be sent at the same time
    - Binary protocol instead of text
    - Server push... server can push files to the client before the client requests them
    - [Into to HTTP/2](https://web.dev/performance-http2/)
    - [HTTP/3](https://blog.cloudflare.com/http3-the-past-present-and-future/)