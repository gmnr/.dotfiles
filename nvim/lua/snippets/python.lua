local u = require("modules.snippets")

return {
  u.tab("pp", { t("print("), i(1), t(")") }),
  u.tab("pl", { t("print("), i(1), t(", sep='\\n')") }),
  u.tab("exit", t("import sys; sys.exit()")),
  u.tab("defaultdict", t("from collections import defaultdict as dd")),
  u.tab("Counter", t("from collections import Counter")),
  u.tab("deque", t("from collections import deque")),
  u.tab("collections", { t("from collections import "), i(1) }),
  u.tab("itertools", { t("from itertools import "), i(1) }),
}
