import "./theatre/core-and-studio.js";
// We can now access Theatre.core and Theatre.studio from here
const { core, studio } = Theatre;

studio.initialize(); // Start the Theatre.js UI

const sound = new Howl({
  src: ["content/how-to-read-the-map.mp3"],
});
const project = core.getProject("Audio Tour Movements", {
  state: howToReadTheMapJson,
});
const sheet = project.sheet("how-to-read-map");

const obj = sheet.object("Map", {
  x: core.types.number(63782.76, { range: [0, 160000] }),
  y: core.types.number(8881, { range: [0, 17764] }), // you can use just a simple default value
  zoom: core.types.number(12.2945, { range: [12.2945, 18] }),
});
// sheet.sequence.attachAudio({ source: 'content/how-to-read-the-map.mp3' }).then(() => {
//   alert("audio loaded")
// });
//const articleHeadingElement = document.getElementById('logo-title')

core.onChange(sheet.sequence.pointer.playing, (playing) => {
  if (playing) {
    sound.seek(sheet.sequence.position);
    sound.play();
  } else {
    sound.stop();
  }
});

obj.onValuesChange((obj) => {
  //sound.play();
  view.setCenter([obj.x, obj.y]);
  view.setZoom(obj.zoom);
  //articleHeadingElement.style.transform = `translateY(${obj.y}px)`
  //articleHeadingElement.style.opacity = obj.opacity
});

//console.log(sheet.sequence.play({ range: [1, 30] }));
