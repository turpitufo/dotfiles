---
status: open
priority: high
due: 2026-08-03
scheduled: 2026-08-03
projects:
  - "[[Combine and Publish nixos config]]"
dateCreated: 2026-08-03T18:48:13.964+02:00
dateModified: 2026-08-03T18:48:13.964+02:00
type: task
---
# NixOS Configuration
**Personal** flake-based NixOS configuration for multiple hosts.
After years and years of distrohopping, I have found home, thanks to NixOS I don't even remember how to create a programs.txt because my Arch/based(BTW) system broke and I have to reinstall. Almost all thanks to [VimJoyer](https://www.youtube.com/@vimjoyer)

## **This configuration uses:**
- [Flakes](https://wiki.nixos.org/wiki/Flakes)
- [Home Manager](https://wiki.nixos.org/wiki/Home_Manager)
- [Agenix](https://wiki.nixos.org/wiki/Agenix) for secret management
- KDE Plasma 6

| name      | model | usecase                    |
| --------- | ----- | -------------------------- |
| rocinante | T480  | school/web/programming     |
| Hal       | L15   | entertainment/game/HomeLab |

This repo went through a major overhaul to combine Hal with rocinante recently. From that point onwards Mistral CLI has been a big help.

## **To Whom It May Concern:** 
- This is a work in progress, and it will always stay that way, plan is to make it reproducible but as of now you have to manually change many thing to use it. Although I doubt you will, please be very careful if you were inspired by it and want to use parts of it. Let alone cloning and using the repo, there are still parts that are not pure enough, not to mention hardware-configuration.nix! Just make sure you know what you are doing.

This repo is not very **"NIX WAY"** at the moment, I plan to change that, but the same config has been running for the last year without any issues, and the part of me who said "If it ain't broke don't fix it" kept winning. 
But since summer arrived I will start tinkering:
## Roadmap
- [ ] Return to Nu Shell on host rocinante
	- nushell kept giving timeout error, it was not about nushell it was a nix syntax error 
- [ ] Finalize nvim setup
	- It is never good enough
- [ ] Declarative Plasma
- [ ] Consider [Dendrindic Patterns](https://github.com/mightyiam/dendritic)

## Mistral error
If you would also like to make the mistral CLI nixokg work in NixOS, there is a workaround that doesn't use overlays. It is currently giving error on PytestCheck phase of build, you will notice when built the TUI is a bit laggy after the workaround.
```python
       > =========================== short test summary info ============================ 
       > FAILED tests/cli/textual\_ui/test\_message\_queue\_ui.py::test\_slash\_command\_rejected\_with\_warning\_when\_busy - assert False 
       >  +  where False = any(<generator object test\_slash\_command\_rejected\_with\_warning\_when\_busy.<locals>.<genexpr> at 0x7fffc5e29d80>) 
       > FAILED tests/tools/test\_ui\_bash\_execution.py::test\_ui\_queues\_bash\_submitted\_while\_command\_running - AssertionError: assert 0 == 1 
       >  +  where 0 = len(MessageQueue(\_items=\[\], \_paused=False)) 
       >  +    where MessageQueue(\_items=\[\], \_paused=False) = VibeApp(title='VibeApp', classes={'-dark-mode', '-theme-ansi-dark'}, pseudo\_classes=
{'dark', 'ansi', 'focus'}).\_input\_queue 
       > ====== 2 failed, 4620 passed, 4 skipped, 28 warnings in 134.15s (0:02:14) ======
```

And the workaround is to define with Home Manager and give it attribute `doInstallCheck = false;`  instead of `doCheck = false;`

```nix
package = pkgs.mistral-vibe.overrideAttrs (old: { 
  #doCheck = false; 
  doInstallCheck = false; 
});
```