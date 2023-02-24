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