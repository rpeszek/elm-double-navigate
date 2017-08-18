_I am keeping this repo around so people who navigate here from [elm-lang ticket 27](https://github.com/elm-lang/navigation/issues/27) can find it_.

src/Main.elm program shows what happens if button inside a form tries to navigate to a hash url.
It seems that the the best thing to do is to keep such buttons outside of the form to avoid DOM gotchas and browser specific behavior.

More detailed description is [here](bugDescription.md)
