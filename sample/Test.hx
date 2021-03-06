import domkit.Builder;

class Obj extends Components.MydivComponent implements domkit.Object {

	static var SRC =
	<mydiv class="foo" padding-left="$value" color="blue">
		@exampleText("!")
		<custom(55) public id="sub" custom-color="#ff0 0.5" active/>
	</mydiv>

	public function new(value,?parent) {
		super(parent);
		initComponent(); // create the component tree
	}

}

class Test {

	public static var exampleText = "Hello World";

	static function main() {
		var o = new Obj(55);
		trace(o.color); // Blue
		trace(o.paddingLeft); // 55
		trace(o.sub.paddingLeft); // 0
		trace( cast(o.getChildren()[0],Components.TextComponent).text ); // "Hello World!"

		var css = new domkit.CssStyle();
		css.add(new domkit.CssParser().parseSheet(sys.io.File.getContent("test.css")));
		o.dom.applyStyle(css);

		trace(o.sub.paddingLeft); // 50

		var elt = o.sub.dom;
		elt.addClass("over");
		o.dom.applyStyle(css);
		trace(o.sub.paddingLeft); // 60

		trace(o.sub.maxWidth); // null

	}

}