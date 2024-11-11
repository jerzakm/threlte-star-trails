<script lang="ts">
	import { Canvas } from '@threlte/core';

	import Scene from './Scene.svelte';
	import Rendering from './renderer/Rendering.svelte';
</script>

<div>
	<Canvas>
		<Scene />
		<Rendering />
	</Canvas>
</div>

<style>
	div {
		position: fixed;
		top: 0;
		left: 0;
		height: 100vh;
		width: 100vw;
		background-color: #222;
	}
</style>
