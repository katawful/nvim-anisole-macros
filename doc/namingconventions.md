# Naming Conventions
Macros available are intended to keep with Fennel [style conventions](https://fennel-lang.org/style#names) as much as possible. The conventions should be understandable at a glance, but for clarity in the project they will be described here.

## Creation, Definition, Clearing, and Deletion
The Neovim API is generally very clear in its naming on what each API function acheives. `nvim_del` is for global deletion operations, `nvim_win_del` for window deletion operations, and so on. In order to maintain this level of explicit clarity, I have used a clear naming convention for each of these base operations:

| Convention | Operation | Description |
|---|---|---|
|`create` | create | For creation of objects, but not return of one |
|`define` | definition | For definition of created objects, returns a value |
|`clear!` | clearing | For clearing of an object's values, but not deletion |
|`delete!` | deletion | For deleting an object entirely |
|`set` | setter | For setting the value of an object |
|`get` | getter | For getting the value of an object |
|`run` | execution | Execute the object |

```fennel
;; No returned value, cannot be manipulated by itself
(command.create :UserCommand (fn [] (print "Hello world")) "Usercomamnd hello world")
;; Returns a value, can be manipulated with 'autocmd' variable
(local user-command (command.define :UserCommand (fn [] (print "Hello world")) "BufEnter hello world")
;; Clear out all "BufEnter" autocommands
(auto.cmd.clear! {:event :BufEnter})
;; Delete 'autocmd' autocommand explicitly
(auto.group.delete! autocmd)
;; Set option 'number'
(options.set number true)
;; Get value of option 'number'
(options.get number)
;; Run VimL function
(command.run.fn has "nvim-0.9")
```

## `!`
In Fennel's style guide, `!` as a suffix refers to file-system operations. I have extended this to imply state updates. `clear!` and `delete!` are explicit updates of Neovim's state, and thus will always be suffixed by `!`.

## `<-`, `->`
In Fennel's style guide, `->` is used for conversion functions. For instance taking a string and making it into a sequential table would be `string->table`. `->` thus gets read as "to", making this function "string to table". This convention is used where appropriate.

Conversely, `<-` becomes "from", and implies a source to look from *or* a file to read from if it is a file system operation. A function to clear an autocommand specifically from a list of events would be `auto.cmd.clear<-event!`. This is generally used when one only wishes to do 1 level of search.
