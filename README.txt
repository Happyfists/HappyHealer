==========================================================================================
  HAPPY HEALER  -  an easy, Cure Please style healer for CatsEyeXI (Ashita v4)   v1.0
==========================================================================================

  Happy Healer is Sidekick by Seekey with a simpler window on top. The healing engine,
  the AFK Sleep protection and every rule Sidekick follows are Sidekick's own; Happy Healer
  only changes how it looks and how you set it up.

  Jobs: WHM, RDM, BRD, COR, SCH and GEO.

------------------------------------------------------------------------------------------
 INSTALL
------------------------------------------------------------------------------------------
    Copy the happyhealer folder into  Ashita\addons\  then in game:
        /addon load happyhealer

------------------------------------------------------------------------------------------
 USING IT
------------------------------------------------------------------------------------------
    /hh          show / hide the Happy Healer window
    /hh start    start healing           /hh stop    stop
    /hh help     every command

    The window (laid out like Cure Please):
      * Main: your party with job pictures, HP and MP. Untick anyone you don't want healed,
        click a name to focus them, big Start / Pause button.
      * Monitored Player: another of your characters running Happy Healer on this PC -
        their party shows up so you can look after it too.
      * Pages: Healing, Debuff Removal, Enhancing, Geomancy (GEO), Bard Songs (BRD),
        Job Abilities, Other Options, Program Options, Save.
      * Hide button (top right) - a small Start / Pause button stays on screen; its ^ opens
        the window again.

------------------------------------------------------------------------------------------
 AFK SLEEP (unchanged from Sidekick)
------------------------------------------------------------------------------------------
    After 10 minutes with no party movement and no combat, Happy Healer goes to sleep and
    does nothing until YOU move your character. Combat alone does not wake it.
    The code is Sidekick's own lib\core\afk.lua, byte for byte.

------------------------------------------------------------------------------------------
 SAVED SETTINGS
------------------------------------------------------------------------------------------
    Ashita\config\addons\happyhealer\   (per character; hh_share\ = parties shared
                                         between your characters on this PC)

------------------------------------------------------------------------------------------
 CREDITS
------------------------------------------------------------------------------------------
    * Sidekick by Seekey (MIT) - the engine: https://github.com/seekey13/Sidekick
      (LICENSE_SIDEKICK)
    * Job icon sheet: points addon by Shinzaku, based on Pointwatch by Byrthnoth
    * Window idea: Cure Please
    * Happy Healer by Happyfists
