#include <emscripten.h>

EM_JS_DEPS(bla, "$UTF8ToString");

EM_JS(void, jsLog, (const char* s), {
  console.log(UTF8ToString(s));
});

void dummy(void) {};
