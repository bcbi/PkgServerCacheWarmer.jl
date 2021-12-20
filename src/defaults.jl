const _DEFAULT_BEFORE_SCRIPT = """
    import Pkg

    Pkg.Registry.add("General")
"""

const _DEFAULT_SCRIPT = """
    import Pkg

    Pkg.instantiate()
    Pkg.update()
"""

const _DEFAULT_AFTER_SCRIPT = """
    import Pkg
"""
