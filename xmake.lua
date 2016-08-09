-- project
set_project("xmake-cpputest")

-- version
set_version("1.0.0")

if is_os("macosx") then
    cpputest_home = "/usr/local/Cellar/cpputest/3.8/"
else
    cpputest_home = "/usr/local/"
end

-- set warning all as error
set_warnings("all", "error")

-- set language: c99, c++11
set_languages("c99", "cxx11")

-- the debug or check or coverage mode
if is_mode("debug", "check", "coverage") then

    -- enable the debug symbols
    set_symbols("debug")

    -- disable optimization
    set_optimize("none")

    -- add defines for debug
    add_defines("__tb_debug__")

    -- attempt to enable some checkers for pc
    if is_mode("check") and is_arch("i386", "x86_64") then
        add_cxflags("-fsanitize=address", "-ftrapv")
        add_mxflags("-fsanitize=address", "-ftrapv")
        add_ldflags("-fsanitize=address")
    end

    -- enable coverage
    if is_mode("coverage") then
        add_cxflags("--coverage")
        add_mxflags("--coverage")
        add_ldflags("--coverage")
    end
end

-- the release mode
if is_mode("release") then

    -- set the symbols visibility: hidden
    set_symbols("hidden")

    -- enable fastest optimization
    set_optimize("fastest")

    -- strip all symbols
    set_strip("all")
end

-- add option: CppUTest
option("CppUTest")
    set_enable(false)
    set_showmenu(true)
    set_category("option")
    set_description("Specify CppUTest Home")

-- if is_option("CppUTest") then CppUTestHome=get_option("CppUTest") end

-- add target
target("tutorial")

    -- set kind
    set_kind("binary")

    -- add include directories
    add_includedirs("include", "include/LedDriver", "mocks", cpputest_home .. "include")

    -- add files
    add_files("src/**.c", "mocks/*.c", "tests/**.cpp")

    -- add link library
    add_links("CppUTest")

    -- add link directories
    add_linkdirs(cpputest_home .. "lib")
    -- add_linkdirs("$(CppUTestHome)lib")

-- add target
target("tut")

    -- set kind
    set_kind("binary")

    -- add files
    add_files("src/Tutorial/*.cxx")
