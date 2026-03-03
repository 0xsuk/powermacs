
<img width="633" height="367" alt="image" src="https://github.com/user-attachments/assets/41406add-da5e-4c72-915e-611025278806" />


## install
git clone this to ~/.emacs.d/ #exact-foldername-match-is-needed

## 構成

| emacs内の構成 |  |
| -- | -- |
| modal editing | meow | 
| terminal | emacs-libvterm |
| lsp | eglot | 
| minibuffer completion | vertico |
| in-buffer completion | corfu | 
| completion helper | orderless (for filtering), prescient (for sorting) |
| git | magit |



| emacs外の構成 | |
| --- | --- |
| OS | ubuntu 22.04 |
| emacs | latest |
| keyboard | laptop keyboard (JIS) | 
| key remapper | keyd (無変換->ctrl , 変換->shift, カタカナひらがなローマ字->esc, CapsLock->f12) |
| browser | brave |
| shell  | bash |
| terminal | emacs-libvterm | 




参考にしたリンク: https://github.com/noctuid/dotfiles/


## お気持ち
- modifier key (ctrl,alt) vs modal editing (vim, kakoune, meow) -> すべての操作をctrl+〇でするのは不便なのでmodal editingで楽をする。しかしPCを使う上でEmacs外でのCtrlキーの使用は避けられず、どの道modifierキーは使うのでkeyboard remapper (software level)で使いやすい位置にCtrl,shift,alt,win,escを置く. またすべての操作をmodal editingでやるのはkey press数的にもったいない。たとえばある操作をctrl+〇でするのと、modal editingで2 key press使う場合を比べると、操作単発の場合どちらも2 key press。しかし前者の場合操作後ctrlを押しつづけていれば1 key pressで繰り返し実行できるし別のコマンドctrl-▲まで1 key press.
- Emacs pinky -> JISキーボードでkeyboard remapperで無変換キーをCtrlに、変換キーをShiftに、カタカナひらがなローマ字キーをEscapeに設定. これによりCtrlは左手親指で押せる
- vterm vs 他 -> vtermならEmacs上で設定した補完、サーチ、キーバインディングをterminalに適用できるので、別terminal emulatorでそれらを再設定しなくて済む。速度、まれに表示バグがデメリット。
