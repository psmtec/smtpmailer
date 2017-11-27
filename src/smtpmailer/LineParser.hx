package smtpmailer;

import tink.io.StreamParser;

class LineParser extends SimpleBytewiseParser<String> {

	var buf: StringBuf = new StringBuf();

	public function new()
		super(readChar);

	function readChar(c: Int): ParseStep<String> {
		return switch c {
			case 10:
				var ret = buf.toString();
				if (ret.charCodeAt(ret.length-1) == 13)
					ret = ret.substr(0, -1);
				if (ret == '')
					Progressed;
				else {
					buf = new StringBuf();
					Done(ret);
				}
			default:
				buf.addChar(c);
				Progressed;
		}
	}
}