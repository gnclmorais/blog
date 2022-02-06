---
title: 'Vortexgear Cypher ⌨️'
date: 2020-10-09 00:00:00
tags: [mechanical keyboards]
layout: post
---

Recently, I had my introduction to mechanical keyboards. After starting with a second-hand Pok3r and trying out a Ducky One 2 SF, a Tab 75 and a Cypher, I think I found a good match.

![Vortexgear Cypher](/images/posts/2020-10-09-vortex-cypher-single-spacebar.png)


## Details
- [Vortexgear Cypher](http://vortexgear.tw/vortex2_2.asp?kind=47&kind2=227&kind3=453&kind4=1058) ([65% layout](https://drop.com/talk/947/physical-keyboard-layouts-explained-in-detail))
- Single spacebar (yes, because there’s a [version with two spacebars](http://vortexgear.tw/vortex2_2.asp?kind=47&kind2=227&kind3=454&kind4=1066))
- [Cherry MX Clear switches](https://deskthority.net/wiki/Cherry_MX_Clear) (medium stiff, tactile, non-clicky)
- ISO-UK layout (big return key)


## Factory layout
[![Default layout from factory](/images/posts/2020-10-09-cypher-layout-factory.png)][default]


## Programming the keyboard
A cool feature of most Vortex keyboards is the ability to program and override almost any key. This is especially important on smaller keyboards, like their [Core 40%](https://mechboards.co.uk/shop/keyboards/vortex-core-40-keyboard/), but it’s still quite useful in order to tune a keyboard just for your use case.

I’ve used a [Pok3r](https://mechboards.co.uk/shop/keyboards/vortex-pok3r-60-keyboard) and it was almost perfect, but the fact it had no dedicated arrow keys was a deal breaker to me(they were only reachable by pressing `Fn` plus other keys). The Cypher model corrects that and, with a few changes, ticks all the boxes for me. Here’s my current layout (lighter grey highlighting the keys I’ve changed):

[![Customised layout](/images/posts/2020-10-09-cypher-layout-custom.png)][custom]

- Windows and Alt key functions were basically swapped because I use macOS everywhere at the moment;
- AltGr is pretty much useless on macOS, so I mapped it to something I use way more while writing JavaScript, a backtick (\`) — otherwise accessible with `Fn+Esc`;
- The Delete function is in a weird place (`Fn+'`), so I mapped it to `Fn+Backspace`;
- Finally, the CapsLock is now two Control presses! This means that pressing this key will be the same as double-tapping the Control key. This sounds odd but iTerm2 has a hotkey feature that allows you to show/hide it either with a key (I’ve used `±` on other keyboards, but Cypher doesn’t have this key) _or_ by double-tapping a modifier key (I’ve found that Control is the one less prone to false double taps).


I won’t include in this post how to customise the keyboard, you can read that directly from the source (by checking the [Cypher’s][cypher] and [Pok3r’s][pok3r] manuals). After a few tweaks, this is my final layout (with preprogrammed media keys Vortex keyboards already include):

[![Final layout with media keys](/images/posts/2020-10-09-cypher-layout-final.png)][final]


---


#### Quick update (Jan. 2022)
Something off is happening with the keyboard, it seems like it still gets electricity (i.e. the lights turn on and I can change modes), but the actual keystrokes don’t reach computers… In the meantime, to fill in the gap, I’ve bought a Magicforce — Gateron brown switches, white & grey keycaps, UK layout. So far, so good!


[default]: http://www.keyboard-layout-editor.com/##@@_c=%23373535&t=%23a8a8a8&a:7%3B&=Esc&_a:4%3B&=!%0A1&=%22%0A2&=%C2%A3%0A3&=$%0A4%0A%0A%E2%82%AC&=%25%0A5&=%5E%0A6&=%2F&%0A7&=*%0A8&=(%0A9&=)%0A0&=%2F_%0A-&=+%0A%2F=&_w:2%3B&=%0A%0A%0ABackspace&_a:5%3B&=%0AHome%3B&@_a:4&w:1.5%3B&=%0ATab&=Q&=W&=E&=R&=T&=Y&=U&=I&=O&=P&=%7B%0A%5B&=%7D%0A%5D&_x:0.25&a:5&w:1.25&h:2&w2:1.5&h2:1&x2:-0.25%3B&=%0AEnter&=%0APgUp%3B&@_a:4&w:1.75%3B&=%0ACapsLock&=A&=S&=D&=F&=G&=H&=J&=K&=L&=%2F:%0A%2F%3B&=%2F@%0A'&=~%0A%23&_x:1.25&a:5%3B&=%0APgDn%3B&@_a:4&w:1.25%3B&=%0AShift&=%7C%0A%5C&=Z&=X&=C&=V&=B&=N&=M&=%3C%0A,&=%3E%0A.&=%3F%0A%2F%2F&_w:1.75%3B&=%0A%0A%0AShift&=%0A%0A%0A%E2%86%91&_a:5%3B&=%0AEnd%3B&@_a:4&w:1.25%3B&=%0ACtrl&_w:1.25%3B&=%0AWin&_w:1.25%3B&=%0AAlt&_a:7&w:6.25%3B&=&_a:4%3B&=%0A%0A%0AAltGr&=%0A%0A%0AFn&=%0A%0A%0APn&=%0A%0A%0A%E2%86%90&=%0A%0A%0A%E2%86%93&=%0A%0A%0A%E2%86%92
[custom]: http://www.keyboard-layout-editor.com/##@@_c=%23373535&t=%23a8a8a8&a:7%3B&=Esc&_a:4%3B&=!%0A1&=%22%0A2&=%C2%A3%0A3&=$%0A4%0A%0A%E2%82%AC&=%25%0A5&=%5E%0A6&=%2F&%0A7&=*%0A8&=(%0A9&=)%0A0&=%2F_%0A-&=+%0A%2F=&_c=%2360605b&a:0&w:2%3B&=%0A%0A%0ABackspace%0A%0ADel&_c=%23373535&a:5%3B&=%0AHome%3B&@_a:4&w:1.5%3B&=%0ATab&=Q&=W&=E&=R&=T&=Y&=U&=I&=O&=P&=%7B%0A%5B&=%7D%0A%5D&_x:0.25&a:5&w:1.25&h:2&w2:1.5&h2:1&x2:-0.25%3B&=%0AEnter&=%0APgUp%3B&@_c=%2360605b&a:4&w:1.75%3B&=%0ACtrlx2%20(iTerm)&_c=%23373535%3B&=A&=S&=D&=F&=G&=H&=J&=K&=L&=%2F:%0A%2F%3B&=%2F@%0A'&=~%0A%23&_x:1.25&a:5%3B&=%0APgDn%3B&@_a:4&w:1.25%3B&=%0AShift&=%7C%0A%5C&=Z&=X&=C&=V&=B&=N&=M&=%3C%0A,&=%3E%0A.&=%3F%0A%2F%2F&_w:1.75%3B&=%0A%0A%0AShift&=%0A%0A%0A%E2%86%91&_a:5%3B&=%0AEnd%3B&@_a:4&w:1.25%3B&=%0ACtrl&_c=%2360605b&w:1.25%3B&=%0A%E2%8C%A5&_w:1.25%3B&=%0A%E2%8C%98&_c=%23373535&a:7&w:6.25%3B&=&_c=%2360605b&a:4%3B&=%0A%0A%0A%60&_c=%23373535%3B&=%0A%0A%0AFn&=%0A%0A%0APn&=%0A%0A%0A%E2%86%90&=%0A%0A%0A%E2%86%93&=%0A%0A%0A%E2%86%92
[final]: http://www.keyboard-layout-editor.com/##@@_c=%23373535&t=%23a8a8a8&a:7%3B&=Esc&_a:4%3B&=!%0A1&=%22%0A2&=%C2%A3%0A3&=$%0A4%0A%0A%E2%82%AC&=%25%0A5&=%5E%0A6&=%2F&%0A7&=*%0A8&=(%0A9&=)%0A0&=%2F_%0A-&=+%0A%2F=&_a:0&w:2%3B&=%0A%0A%0ABackspace%0A%0ADel&_a:5%3B&=%0AHome%3B&@_a:4&w:1.5%3B&=%0ATab&=Q%0A%0A%0A%0APrev&=W%0A%0A%0A%0APlay&=E%0A%0A%0A%0ANext&=R&=T&=Y&=U&=I&=O&=P&=%7B%0A%5B&=%7D%0A%5D&_x:0.25&a:5&w:1.25&h:2&w2:1.5&h2:1&x2:-0.25%3B&=%0AEnter&=%0APgUp%3B&@_a:4&w:1.75%3B&=%0ACtrl%20x%202&=A&=S%0A%0A%0A%0AVol-&=D%0A%0A%0A%0AVol+&=F%0A%0A%0A%0AMute&=G&=H&=J&=K&=L&=%2F:%0A%2F%3B&=%2F@%0A'&=~%0A%23&_x:1.25&a:5%3B&=%0APgDn%3B&@_a:4&w:1.25%3B&=%0AShift&=%7C%0A%5C&=Z&=X&=C&=V&=B&=N&=M&=%3C%0A,&=%3E%0A.&=%3F%0A%2F%2F&_w:1.75%3B&=%0A%0A%0AShift&=%0A%0A%0A%E2%86%91&_a:5%3B&=%0AEnd%3B&@_a:4&w:1.25%3B&=%0ACtrl&_w:1.25%3B&=%0A%E2%8C%A5&_w:1.25%3B&=%0A%E2%8C%98&_a:7&w:6.25%3B&=&_a:4%3B&=%0A%0A%0A%60&=%0A%0A%0AFn&=%0A%0A%0APn&=%0A%0A%0A%E2%86%90&=%0A%0A%0A%E2%86%93&=%0A%0A%0A%E2%86%92
[cypher]: https://duckduckgo.com/?q=vortex+cypher+manual
[pok3r]: https://duckduckgo.com/?q=vortex+pok3r+manual
