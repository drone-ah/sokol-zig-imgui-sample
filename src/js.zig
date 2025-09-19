pub fn log(ptr: [*]const u8) void {
    jsLog(ptr);
}

pub fn debug() void {}

extern fn jsLog(ptr: [*]const u8) void;

/// 2. Keep a reference to avoid the linker removing the function.
///    Same role as __em_js_ref_* in the C macro.
pub export const __em_js_ref_jsLog = &jsLog;

/// 3. Embed the JS implementation in a special section called "em_js".
///    Emscripten will scan this and inject the code into the output JS.
//export const __em_js__jsLog align(1) linksection("em_js") =
//    "(const char* s)<::>{ console.log(UTF8ToString(s)); }\x00";

// hardcoded so it's not just a pointer
export const __em_js__jsLog align(1) linksection("em_js") = [_]u8{
    '(', 'c', 'o', 'n', 's', 't', ' ', 'c',    'h', 'a', 'r', '*', ' ', 's', ')',
    '<', ':', ':', '>', '{', ' ', 'c', 'o',    'n', 's', 'o', 'l', 'e', '.', 'l',
    'o', 'g', '(', 'U', 'T', 'F', '8', 'T',    'o', 'S', 't', 'r', 'i', 'n', 'g',
    '(', 's', ')', ')', ';', ' ', '}', '\x00',
};

pub export fn dummy() void {}
