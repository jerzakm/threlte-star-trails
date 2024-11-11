<script lang="ts">
	import { BufferAttribute, BufferGeometry, Points, PointsMaterial } from 'three';
	import { T } from '@threlte/core';

	function createStarsGeometry(count = 10000, radius = 10) {
		const positions = new Float32Array(count * 3);

		for (let i = 0; i < count; i++) {
			const index3 = i * 3;

			const phi = Math.random() * Math.PI * 2; // 0 to 2π
			const cosTheta = Math.random() * 2 - 1; // -1 to 1
			const theta = Math.acos(cosTheta); // 0 to π

			positions[index3] = radius * Math.sin(theta) * Math.cos(phi); // x
			positions[index3 + 1] = radius * Math.sin(theta) * Math.sin(phi); // y
			positions[index3 + 2] = radius * Math.cos(theta); // z
		}

		const geometry = new BufferGeometry();
		geometry.setAttribute('position', new BufferAttribute(positions, 3));

		return geometry;
	}

	const starsMaterial = new PointsMaterial({
		size: 0.05,
		color: 0xffffff,
		sizeAttenuation: true
	});

	const starsGeometry = createStarsGeometry();
	const starsPoints = new Points(starsGeometry, starsMaterial);
</script>

<T is={starsPoints} />
