shader_type canvas_item;
uniform float offset = 5f;
void vertex() {
	VERTEX.x += cos(TIME) * offset;
	VERTEX.y += sin(TIME) * offset;
}