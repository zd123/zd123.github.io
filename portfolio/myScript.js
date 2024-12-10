
var count = 150;
var path = new Path.Circle(new Point(0,0), 10);
var text = new PointText(view.center);
text.fillColor = 'white';
text.content = 'ZACK DESARIO';

path.style = {
	fillColor:'white'
};

var symbol = new Symbol(path);

for (var i = 0; i < count; i++) {
	// the center position is a random point nigga
	var center = Point.random() * view.size;
	var placedSymbol = symbol.place(center);
	placedSymbol.scale(i / count);
}

function onFrame(event) {
	
	for (var i = 0; i < count; i++) {
		var shit = project.activeLayer.children[i];
		shit.position.x += shit.bounds.width/20;
	}
	
}
