def define_env(env):
    """
    This function is called once when building the site.
    Use it to define macros, variables, and filters.
    """

    # Example: a simple macro
    @env.macro
    def shout(text):
        return text.upper()

    # Example: a variable available everywhere
    env.variables["project_name"] = "My Cool Project"

    # Example: a filter
    @env.filter
    def reverse_string(value):
        return value[::-1]