<script lang="ts">
	import { T, useTask, useThrelte, watch } from '@threlte/core';

	import * as THREE from 'three';

	import fragmentShader from './trails_fs.glsl?raw';
	import vertexShader from './_vs.glsl?raw';

	const { size, renderer, scene, camera, renderStage, autoRender } = useThrelte();

	autoRender.set(false);

	const sceneRt = new THREE.WebGLRenderTarget($size.width, $size.height, {
		format: THREE.RGBAFormat,
		minFilter: THREE.NearestFilter,
		magFilter: THREE.NearestFilter
	});

	const postCamera = new THREE.OrthographicCamera(-1, 1, 1, -1, 0, 1);
	const postScene = new THREE.Scene();
	const postMaterial = new THREE.ShaderMaterial({
		name: 'Trails',
		vertexShader,
		fragmentShader,
		uniforms: {
			liveScene: { value: sceneRt.texture },
			previousFinalRender: { value: null }
		}
	});

	const postQuad = new THREE.Mesh(new THREE.PlaneGeometry(2, 2), postMaterial);

	postScene.add(postQuad);

	const postRt1 = new THREE.WebGLRenderTarget($size.width, $size.height, {
		format: THREE.RGBAFormat,
		minFilter: THREE.NearestFilter,
		magFilter: THREE.NearestFilter
	});

	const postRt2 = new THREE.WebGLRenderTarget($size.width, $size.height, {
		format: THREE.RGBAFormat,
		minFilter: THREE.NearestFilter,
		magFilter: THREE.NearestFilter
	});

	let frame = 0;

	useTask(
		() => {
			frame++;

			renderer.setRenderTarget(sceneRt);
			renderer.clear();
			renderer.render(scene, camera.current);

			if (frame % 2 === 0) {
				postMaterial.uniforms.previousFinalRender.value = postRt2.texture;
				postMaterial.uniforms.liveScene.value = sceneRt.texture;
				renderer.setRenderTarget(postRt1);
			} else {
				postMaterial.uniforms.previousFinalRender.value = postRt1.texture;
				postMaterial.uniforms.liveScene.value = sceneRt.texture;
				renderer.setRenderTarget(postRt2);
			}

			renderer.render(postScene, postCamera);

			renderer.setRenderTarget(null);
			renderer.render(postScene, postCamera);
		},
		{
			stage: renderStage,
			autoInvalidate: true
		}
	);
</script>
