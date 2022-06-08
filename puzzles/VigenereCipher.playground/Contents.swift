import UIKit

//: # Substitutation and transposition Ciphers
//: Before computer, cryptography consisted of  character based algorithms. Different cryptographic algorithms either substituted characters for on another or transposed  characters with on another. The better algorithms die both, many times each.
//:
//: Things are mor complex these days, but the philosophy remains the same. Ther primary change is that algorithms work on bit instead of characters. This is actually just a change in the alphabet size: from 26 elements to two elements. Most good algorithms still combine elments of substitution and transposition.
//:
//:## Substituation Ciphers
//: A substituton cipher is one in which each character in the plaintext is substituted for another character in the ciphertext. The receiver inverts the substitution on ciphertext to recover the plaintext.
//:
//: In classical cryptography, there are four types of substitutions ciphers:
//: * A  **monoalphabetic substitution cipher**, is one in whcih each character of the plaintext is replaced with a corresponding characger of ciphtertext.
//: A **homophonic or simple substiution cipher*" is like a simple substitution cryptosystem, except a single character of plaingtext can map to one of several characters of ciphertext. For example, "A" could correspond to either 5,13,25, or 56 and do on.
//: A **Polygram substitution cipher** is one in which blocks of characters are encrypted in groups. For example "ABA" could correspoind to "RTQ", "ABB" could correspond to "SLL", and so on.
//: A **polyalphabetic substitution cipher** is mad up of multiple simple substitution ciphers. For example, there might be firve different simple substiution ciphers used; the paricular one used changes with the poxsition of each chafracgter of the plaintext.

//: In this playground we will have a look at 




