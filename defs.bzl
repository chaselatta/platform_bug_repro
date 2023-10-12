def _color_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        color = ctx.attr.color
    )
    return [toolchain_info]

color_toolchain = rule(
    implementation = _color_toolchain_impl,
    attrs = {
        "color": attr.string(),
    },
)

def _color_transition_impl(_, attr):
    if len(attr.rule_supplied_platforms) == 0:
        return {}

    return {
        "//command_line_option:platforms": attr.rule_supplied_platforms
    }

color_transition = transition(
    implementation = _color_transition_impl,
    inputs = [],
    outputs = [
        "//command_line_option:platforms",
    ],
)


def _print_color_impl(ctx):
    toolchain = ctx.toolchains[":toolchain_type"]
    print("The color is ", toolchain.color)


print_color = rule(
    implementation = _print_color_impl,
    toolchains = [":toolchain_type"],
    cfg = color_transition,
    attrs = {
        "rule_supplied_platforms": attr.label_list(),
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
    }
)
