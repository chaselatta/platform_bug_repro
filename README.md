# Repro case for <https://github.com/bazelbuild/bazel/issues/19807>

# Show adding --platforms twice

```
bazel build :print_color # fails as expected
bazel build :print_color --platforms=:blue_platform  # prints blue
bazel build :print_color --platforms=:red_platform  # prints red
bazel build :print_color  --platforms=:blue_platform --platforms=:red_platform # prints red
bazel build :print_color  --platforms=:red_platform --platforms=:blue_platform # prints blue
```

# show that returning multiple platforms in a transition uses the first value in the list

```
bazel build :print_color_red_first # prints red
bazel build :print_color_blue_first # prints blue
```
