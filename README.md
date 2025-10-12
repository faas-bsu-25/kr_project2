<h1>kr_project2</h1>
<p>
  A top-down 2D game that focuses on level devices, NPCs, SFX and VFX, and the
  proverbial juice.
</p>

<details>
  <summary><h2>Requirements</h2></summary>
  <ul>
	<li>3 level devices (doors, ladder, spring)</li>
	<ul>
	  <li>At least one must communicate with the game singleton</li>
	</ul>
	<li>
	  1 collectible that is used to control access to other parts of the level
	</li>
	<ul>
	  <li>Ammo, keys, gems</li>
	</ul>
	<li>
	  Playable character (use Godot's build in script to start if making a
      platformer)
    </li>
    <li>2 levels minimum</li>
    <li>1 start screen</li>
    <li>2 NPCs (enemies or friendly) that reacts to the player</li>
    <li>4 relevant sound effects / audio</li>
    <li>Complete graphics - level, enemies, background, interactables</li>
    <li>Polish / juice</li>
  </ul>
  <sup
    ><i
      >Adapted from
      <a
        href="https://bsu.instructure.com/courses/177112/pages/project-2"
        target="_blank"
        >Project 2 Description</a
      >
      on Canvas.</i
    ></sup
  >
</details>

<h2>Assets Used</h2>
<a href="https://toadzillart.itch.io/dungeons-pack" target="_blank">
  <img
    src="https://img.itch.zone/aW1nLzE1MzE3ODYxLmdpZg==/original/R9Cmel.gif"
	alt='"Super Gameboy Quest - Dungeons pack" by Toadzillart on itch.io'
    height="160px"
  />
</a>
<a href="https://toadzillart.itch.io/Monster-pack" target="_blank">
  <img
    src="https://img.itch.zone/aW1nLzE1MzE3ODc0LmdpZg==/original/ZywAS6.gif"
	alt='"Super Gameboy Quest - Enemies pack" by Toadzillart on itch.io'
    height="160px"
  />
</a>
<a href="https://toadzillart.itch.io/ui-pack" target="_blank">
  <img
    src="https://img.itch.zone/aW1nLzE1MzE3ODgwLmdpZg==/original/KsyOhU.gif"
	alt='"Super Gameboy Quest - UI pack" by Toadzillart on itch.io'
    height="160px"
  />
</a>
<a href="https://pixel-boy.itch.io/icon-godot-node" target="_blank">
  <img
    src="https://img.itch.zone/aW1nLzE3MTM0MjcwLnBuZw==/315x250%23c/er89Ot.png"
	alt='"Icon Node For Godot" by pixel-boy on itch.io'
    height="160px"
  />
</a>

<h2>Useful Links</h2>
<nav>
  <li>
    <a
      href="https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/static_typing.html#how-to-use-static-typing"
      target="_blank"
      >Static typing in GDScript</a
    >
  </li>
  <li>
    <a
      href="https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html"
      target="_blank"
      >GDScript style guide</a
    >
  </li>
  <li>
    <a
      href="https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html"
      target="_blank"
      >GDScript reference</a
    >
  </li>
  <li>
    <a
      href="https://docs.godotengine.org/en/latest/tutorials/animation/animation_tree.html"
      target="_blank"
      >Using AnimationTree</a
    >
  </li>
  <li>
    <a
      href="https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html"
      target="_blank"
      >GDScript style guide</a
    >
  </li>
  <li>
    <a
      href="https://github.com/godotengine/godot-docs-user-notes/discussions/5#discussioncomment-8124099"
      target="_blank"
      >SignalBus comment thread</a
    >
  <li>
    <a
      href="https://docs.godotengine.org/en/stable/tutorials/plugins/running_code_in_the_editor.html"
      target="_blank"
      >Running code in the editor</a
    >
  </li>
  <li>
    <a
      href="https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_exports.html"
      target="_blank"
      >GDScript exported properties</a
    >
  </li>
  <li>
    <a
      href="https://docs.godotengine.org/en/stable/classes/class_callable.html#class-callable-method-call-deferred"
      target="_blank"
      ><code>Callable.call_deferred(...args)</code></a
    >
  </li>
  <br />
  <li><a href="https://palcehold.co">Placehold</a> (used for colors)</li>
</nav>

<h2>Error Documentation Journal</h2>
<sup><i>may they happen now so that they never happen again.</i></sup>

<h3>This is so complicated (10/11)</h3>
<p>Usually when I crack open some code for an assignment
--or even for a lab in here--
I can breeze through it without much trouble.</p>

<p>But trying to make a whole game like this? 
It's so hard to find a good wayto write this code. 
I was about to make subclasses of a PickupItem where the scripts only contained class names.
How on earth did my line of reasoning get to <i>that?</i></p>

<h3>Tool Script MEGA troubles (also 10/11)</h3>
<p>Dr. Faas, if you're reading this, you might remember my 
<a href="https://discord.com/channels/829049561867485203/829049561867485206/1426747719883690065">spiel</a> 
on Discord.</p>

<h2>Notes</h2>
<h3>Color Palette</h3>
<p>The Super Gameboy Quest assets feature the following 2-bit color palette:</p>
<ul>
  <li>
	<img src="https://placehold.co/15x15/d4d29b/d4d29b.png" alt="" />
	<code>#d4d29b</code>
  </li>
  <li>
	<img src="https://placehold.co/15x15/78a46a/78a46a.png" alt="" />
	<code>#78a46a</code>
  </li>
  <li>
	<img src="https://placehold.co/15x15/5e8549/5e8549.png" alt="" />
	<code>#5e8549</code>
  </li>
  <li>
	<img src="https://placehold.co/15x15/584422/584422.png" alt="" />
	<code>#584422</code>
  </li>
</ul>
