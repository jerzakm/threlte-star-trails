<script lang="ts">
	import { T } from '@threlte/core';
	import { Gizmo, OrbitControls } from '@threlte/extras';

	import { BoxGeometry, MeshStandardMaterial } from 'three';
	import Stars from './Stars.svelte';
</script>

<T.PerspectiveCamera makeDefault position={[0, 5, 0]} lookAt.y={0.5}>
	<OrbitControls />
</T.PerspectiveCamera>

<T.DirectionalLight position.y={10} position.z={10} />
<T.AmbientLight intensity={0.3} />

<Stars />
