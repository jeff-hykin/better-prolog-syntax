# Before and After (XD Theme: MixItUp variant)
Before                     | After 
:-------------------------:|:-------------------------:
![code_before](https://user-images.githubusercontent.com/17692058/140219985-df9f82a2-e3bf-4c18-b9b6-abca88d44733.png) | ![code_after](https://user-images.githubusercontent.com/17692058/140220023-cd68f0fd-146c-4af0-bd47-4bf85c4ee2b4.png)

## How do I use it?
- If you already have the Prolog extension, sadly it needs to be disabled or uninstalled first because it will override this extension.
- Perl unfortunately chose to have the same file extension as Prolog (`.pl`), and Perl is a built-in language.
  - so, to make the file show up as Prolog, follow this guide. [guide](https://www.gyanblog.com/vscode/visual-studio-code-associate-file-extensions-language/)
  - basically replace their `"*.module": "php", ` with `"*.pl": "prolog", `
  - (if the changes don't seem to apply, try reloading VS Code)
- After that just install the VS Code extension and the changes will automatically be applied.


# What does this do?
This will get you the bleeding-edge syntax highlighting for Prolog. Which means your theme will be able to color your code better.

NOTE: The default VS Code theme does not color much. Switch to the Dark+ theme (installed by default) or use a theme like one of the following to benefit from the changes:
- [XD Theme](https://marketplace.visualstudio.com/items?itemName=jeff-hykin.xd-theme)
- [Noctis](https://marketplace.visualstudio.com/items?itemName=liviuschera.noctis)
- [Kary Pro Colors](https://marketplace.visualstudio.com/items?itemName=karyfoundation.theme-karyfoundation-themes)
- [Material Theme](https://marketplace.visualstudio.com/items?itemName=Equinusocio.vsc-material-theme)
- [One Monokai Theme](https://marketplace.visualstudio.com/items?itemName=azemoh.one-monokai)
- [Winteriscoming](https://marketplace.visualstudio.com/items?itemName=johnpapa.winteriscoming)
- [Popping and Locking](https://marketplace.visualstudio.com/items?itemName=hedinne.popping-and-locking-vscode)
- [Syntax Highlight Theme](https://marketplace.visualstudio.com/items?itemName=peaceshi.syntax-highlight)
- [Default Theme Enhanced](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools-themes)

### Like this extension?
You'll probably like this as well: [The Better Syntax Megapack](https://marketplace.visualstudio.com/items?itemName=jeff-hykin.better-syntax)

## Contributing
If you'd like to help improve the syntax, take a look at `main/main.rb`. And make sure to take a look at `CONTRIBUTING.md` to get a better idea of how code works.
