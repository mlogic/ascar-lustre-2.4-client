# generated automatically by aclocal 1.12.2 -*- Autoconf -*-

# Copyright (C) 1996-2012 Free Software Foundation, Inc.

# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

m4_ifndef([AC_AUTOCONF_VERSION],
  [m4_copy([m4_PACKAGE_VERSION], [AC_AUTOCONF_VERSION])])dnl
m4_if(m4_defn([AC_AUTOCONF_VERSION]), [2.69],,
[m4_warning([this file was generated for autoconf 2.69.
You have another version of autoconf.  It may work, but is not guaranteed to.
If you have problems, you may need to regenerate the build system entirely.
To do so, use the procedure documented by the package, typically 'autoreconf'.])])

# Copyright (C) 2002-2012 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 8

# AM_AUTOMAKE_VERSION(VERSION)
# ----------------------------
# Automake X.Y traces this macro to ensure aclocal.m4 has been
# generated from the m4 files accompanying Automake X.Y.
# (This private macro should not be called outside this file.)
AC_DEFUN([AM_AUTOMAKE_VERSION],
[am__api_version='1.12'
dnl Some users find AM_AUTOMAKE_VERSION and mistake it for a way to
dnl require some minimum version.  Point them to the right macro.
m4_if([$1], [1.12.2], [],
      [AC_FATAL([Do not call $0, use AM_INIT_AUTOMAKE([$1]).])])dnl
])

# _AM_AUTOCONF_VERSION(VERSION)
# -----------------------------
# aclocal traces this macro to find the Autoconf version.
# This is a private macro too.  Using m4_define simplifies
# the logic in aclocal, which can simply ignore this definition.
m4_define([_AM_AUTOCONF_VERSION], [])

# AM_SET_CURRENT_AUTOMAKE_VERSION
# -------------------------------
# Call AM_AUTOMAKE_VERSION and AM_AUTOMAKE_VERSION so they can be traced.
# This function is AC_REQUIREd by AM_INIT_AUTOMAKE.
AC_DEFUN([AM_SET_CURRENT_AUTOMAKE_VERSION],
[AM_AUTOMAKE_VERSION([1.12.2])dnl
m4_ifndef([AC_AUTOCONF_VERSION],
  [m4_copy([m4_PACKAGE_VERSION], [AC_AUTOCONF_VERSION])])dnl
_AM_AUTOCONF_VERSION(m4_defn([AC_AUTOCONF_VERSION]))])

# Figure out how to run the assembler.                      -*- Autoconf -*-

# Copyright (C) 2001-2012 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 5

# AM_PROG_AS
# ----------
AC_DEFUN([AM_PROG_AS],
[# By default we simply use the C compiler to build assembly code.
AC_REQUIRE([AC_PROG_CC])
test "${CCAS+set}" = set || CCAS=$CC
test "${CCASFLAGS+set}" = set || CCASFLAGS=$CFLAGS
AC_ARG_VAR([CCAS],      [assembler compiler command (defaults to CC)])
AC_ARG_VAR([CCASFLAGS], [assembler compiler flags (defaults to CFLAGS)])
_AM_IF_OPTION([no-dependencies],, [_AM_DEPENDENCIES([CCAS])])dnl
])

# AM_AUX_DIR_EXPAND                                         -*- Autoconf -*-

# Copyright (C) 2001-2012 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 2

# For projects using AC_CONFIG_AUX_DIR([foo]), Autoconf sets
# $ac_aux_dir to '$srcdir/foo'.  In other projects, it is set to
# '$srcdir', '$srcdir/..', or '$srcdir/../..'.
#
# Of course, Automake must honor this variable whenever it calls a
# tool from the auxiliary directory.  The problem is that $srcdir (and
# therefore $ac_aux_dir as well) can be either absolute or relative,
# depending on how configure is run.  This is pretty annoying, since
# it makes $ac_aux_dir quite unusable in subdirectories: in the top
# source directory, any form will work fine, but in subdirectories a
# relative path needs to be adjusted first.
#
# $ac_aux_dir/missing
#    fails when called from a subdirectory if $ac_aux_dir is relative
# $top_srcdir/$ac_aux_dir/missing
#    fails if $ac_aux_dir is absolute,
#    fails when called from a subdirectory in a VPATH build with
#          a relative $ac_aux_dir
#
# The reason of the latter failure is that $top_srcdir and $ac_aux_dir
# are both prefixed by $srcdir.  In an in-source build this is usually
# harmless because $srcdir is '.', but things will broke when you
# start a VPATH build or use an absolute $srcdir.
#
# So we could use something similar to $top_srcdir/$ac_aux_dir/missing,
# iff we strip the leading $srcdir from $ac_aux_dir.  That would be:
#   am_aux_dir='\$(top_srcdir)/'`expr "$ac_aux_dir" : "$srcdir//*\(.*\)"`
# and then we would define $MISSING as
#   MISSING="\${SHELL} $am_aux_dir/missing"
# This will work as long as MISSING is not called from configure, because
# unfortunately $(top_srcdir) has no meaning in configure.
# However there are other variables, like CC, which are often used in
# configure, and could therefore not use this "fixed" $ac_aux_dir.
#
# Another solution, used here, is to always expand $ac_aux_dir to an
# absolute PATH.  The drawback is that using absolute paths prevent a
# configured tree to be moved without reconfiguration.

AC_DEFUN([AM_AUX_DIR_EXPAND],
[dnl Rely on autoconf to set up CDPATH properly.
AC_PREREQ([2.50])dnl
# expand $ac_aux_dir to an absolute path
am_aux_dir=`cd $ac_aux_dir && pwd`
])

# AM_CONDITIONAL                                            -*- Autoconf -*-

# Copyright (C) 1997-2012 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 10

# AM_CONDITIONAL(NAME, SHELL-CONDITION)
# -------------------------------------
# Define a conditional.
AC_DEFUN([AM_CONDITIONAL],
[AC_PREREQ([2.52])dnl
 m4_if([$1], [TRUE],  [AC_FATAL([$0: invalid condition: $1])],
       [$1], [FALSE], [AC_FATAL([$0: invalid condition: $1])])dnl
AC_SUBST([$1_TRUE])dnl
AC_SUBST([$1_FALSE])dnl
_AM_SUBST_NOTMAKE([$1_TRUE])dnl
_AM_SUBST_NOTMAKE([$1_FALSE])dnl
m4_define([_AM_COND_VALUE_$1], [$2])dnl
if $2; then
  $1_TRUE=
  $1_FALSE='#'
else
  $1_TRUE='#'
  $1_FALSE=
fi
AC_CONFIG_COMMANDS_PRE(
[if test -z "${$1_TRUE}" && test -z "${$1_FALSE}"; then
  AC_MSG_ERROR([[conditional "$1" was never defined.
Usually this means the macro was only invoked conditionally.]])
fi])])

# Copyright (C) 1999-2012 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 17

# There are a few dirty hacks below to avoid letting 'AC_PROG_CC' be
# written in clear, in which case automake, when reading aclocal.m4,
# will think it sees a *use*, and therefore will trigger all it's
# C support machinery.  Also note that it means that autoscan, seeing
# CC etc. in the Makefile, will ask for an AC_PROG_CC use...


# _AM_DEPENDENCIES(NAME)
# ----------------------
# See how the compiler implements dependency checking.
# NAME is "CC", "CXX", "OBJC", "OBJCXX", "UPC", or "GJC".
# We try a few techniques and use that to set a single cache variable.
#
# We don't AC_REQUIRE the corresponding AC_PROG_CC since the latter was
# modified to invoke _AM_DEPENDENCIES(CC); we would have a circular
# dependency, and given that the user is not expected to run this macro,
# just rely on AC_PROG_CC.
AC_DEFUN([_AM_DEPENDENCIES],
[AC_REQUIRE([AM_SET_DEPDIR])dnl
AC_REQUIRE([AM_OUTPUT_DEPENDENCY_COMMANDS])dnl
AC_REQUIRE([AM_MAKE_INCLUDE])dnl
AC_REQUIRE([AM_DEP_TRACK])dnl

m4_if([$1], [CC],   [depcc="$CC"   am_compiler_list=],
      [$1], [CXX],  [depcc="$CXX"  am_compiler_list=],
      [$1], [OBJC], [depcc="$OBJC" am_compiler_list='gcc3 gcc'],
      [$1], [OBJCXX], [depcc="$OBJCXX" am_compiler_list='gcc3 gcc'],
      [$1], [UPC],  [depcc="$UPC"  am_compiler_list=],
      [$1], [GCJ],  [depcc="$GCJ"  am_compiler_list='gcc3 gcc'],
                    [depcc="$$1"   am_compiler_list=])

AC_CACHE_CHECK([dependency style of $depcc],
               [am_cv_$1_dependencies_compiler_type],
[if test -z "$AMDEP_TRUE" && test -f "$am_depcomp"; then
  # We make a subdir and do the tests there.  Otherwise we can end up
  # making bogus files that we don't know about and never remove.  For
  # instance it was reported that on HP-UX the gcc test will end up
  # making a dummy file named 'D' -- because '-MD' means "put the output
  # in D".
  rm -rf conftest.dir
  mkdir conftest.dir
  # Copy depcomp to subdir because otherwise we won't find it if we're
  # using a relative directory.
  cp "$am_depcomp" conftest.dir
  cd conftest.dir
  # We will build objects and dependencies in a subdirectory because
  # it helps to detect inapplicable dependency modes.  For instance
  # both Tru64's cc and ICC support -MD to output dependencies as a
  # side effect of compilation, but ICC will put the dependencies in
  # the current directory while Tru64 will put them in the object
  # directory.
  mkdir sub

  am_cv_$1_dependencies_compiler_type=none
  if test "$am_compiler_list" = ""; then
     am_compiler_list=`sed -n ['s/^#*\([a-zA-Z0-9]*\))$/\1/p'] < ./depcomp`
  fi
  am__universal=false
  m4_case([$1], [CC],
    [case " $depcc " in #(
     *\ -arch\ *\ -arch\ *) am__universal=true ;;
     esac],
    [CXX],
    [case " $depcc " in #(
     *\ -arch\ *\ -arch\ *) am__universal=true ;;
     esac])

  for depmode in $am_compiler_list; do
    # Setup a source with many dependencies, because some compilers
    # like to wrap large dependency lists on column 80 (with \), and
    # we should not choose a depcomp mode which is confused by this.
    #
    # We need to recreate these files for each test, as the compiler may
    # overwrite some of them when testing with obscure command lines.
    # This happens at least with the AIX C compiler.
    : > sub/conftest.c
    for i in 1 2 3 4 5 6; do
      echo '#include "conftst'$i'.h"' >> sub/conftest.c
      # Using ": > sub/conftst$i.h" creates only sub/conftst1.h with
      # Solaris 10 /bin/sh.
      echo '/* dummy */' > sub/conftst$i.h
    done
    echo "${am__include} ${am__quote}sub/conftest.Po${am__quote}" > confmf

    # We check with '-c' and '-o' for the sake of the "dashmstdout"
    # mode.  It turns out that the SunPro C++ compiler does not properly
    # handle '-M -o', and we need to detect this.  Also, some Intel
    # versions had trouble with output in subdirs.
    am__obj=sub/conftest.${OBJEXT-o}
    am__minus_obj="-o $am__obj"
    case $depmode in
    gcc)
      # This depmode causes a compiler race in universal mode.
      test "$am__universal" = false || continue
      ;;
    nosideeffect)
      # After this tag, mechanisms are not by side-effect, so they'll
      # only be used when explicitly requested.
      if test "x$enable_dependency_tracking" = xyes; then
	continue
      else
	break
      fi
      ;;
    msvc7 | msvc7msys | msvisualcpp | msvcmsys)
      # This compiler won't grok '-c -o', but also, the minuso test has
      # not run yet.  These depmodes are late enough in the game, and
      # so weak that their functioning should not be impacted.
      am__obj=conftest.${OBJEXT-o}
      am__minus_obj=
      ;;
    none) break ;;
    esac
    if depmode=$depmode \
       source=sub/conftest.c object=$am__obj \
       depfile=sub/conftest.Po tmpdepfile=sub/conftest.TPo \
       $SHELL ./depcomp $depcc -c $am__minus_obj sub/conftest.c \
         >/dev/null 2>conftest.err &&
       grep sub/conftst1.h sub/conftest.Po > /dev/null 2>&1 &&
       grep sub/conftst6.h sub/conftest.Po > /dev/null 2>&1 &&
       grep $am__obj sub/conftest.Po > /dev/null 2>&1 &&
       ${MAKE-make} -s -f confmf > /dev/null 2>&1; then
      # icc doesn't choke on unknown options, it will just issue warnings
      # or remarks (even with -Werror).  So we grep stderr for any message
      # that says an option was ignored or not supported.
      # When given -MP, icc 7.0 and 7.1 complain thusly:
      #   icc: Command line warning: ignoring option '-M'; no argument required
      # The diagnosis changed in icc 8.0:
      #   icc: Command line remark: option '-MP' not supported
      if (grep 'ignoring option' conftest.err ||
          grep 'not supported' conftest.err) >/dev/null 2>&1; then :; else
        am_cv_$1_dependencies_compiler_type=$depmode
        break
      fi
    fi
  done

  cd ..
  rm -rf conftest.dir
else
  am_cv_$1_dependencies_compiler_type=none
fi
])
AC_SUBST([$1DEPMODE], [depmode=$am_cv_$1_dependencies_compiler_type])
AM_CONDITIONAL([am__fastdep$1], [
  test "x$enable_dependency_tracking" != xno \
  && test "$am_cv_$1_dependencies_compiler_type" = gcc3])
])


# AM_SET_DEPDIR
# -------------
# Choose a directory name for dependency files.
# This macro is AC_REQUIREd in _AM_DEPENDENCIES.
AC_DEFUN([AM_SET_DEPDIR],
[AC_REQUIRE([AM_SET_LEADING_DOT])dnl
AC_SUBST([DEPDIR], ["${am__leading_dot}deps"])dnl
])


# AM_DEP_TRACK
# ------------
AC_DEFUN([AM_DEP_TRACK],
[AC_ARG_ENABLE([dependency-tracking], [dnl
AS_HELP_STRING(
  [--enable-dependency-tracking],
  [do not reject slow dependency extractors])
AS_HELP_STRING(
  [--disable-dependency-tracking],
  [speeds up one-time build])])
if test "x$enable_dependency_tracking" != xno; then
  am_depcomp="$ac_aux_dir/depcomp"
  AMDEPBACKSLASH='\'
  am__nodep='_no'
fi
AM_CONDITIONAL([AMDEP], [test "x$enable_dependency_tracking" != xno])
AC_SUBST([AMDEPBACKSLASH])dnl
_AM_SUBST_NOTMAKE([AMDEPBACKSLASH])dnl
AC_SUBST([am__nodep])dnl
_AM_SUBST_NOTMAKE([am__nodep])dnl
])

# Generate code to set up dependency tracking.              -*- Autoconf -*-

# Copyright (C) 1999-2012 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 6

# _AM_OUTPUT_DEPENDENCY_COMMANDS
# ------------------------------
AC_DEFUN([_AM_OUTPUT_DEPENDENCY_COMMANDS],
[{
  # Autoconf 2.62 quotes --file arguments for eval, but not when files
  # are listed without --file.  Let's play safe and only enable the eval
  # if we detect the quoting.
  case $CONFIG_FILES in
  *\'*) eval set x "$CONFIG_FILES" ;;
  *)   set x $CONFIG_FILES ;;
  esac
  shift
  for mf
  do
    # Strip MF so we end up with the name of the file.
    mf=`echo "$mf" | sed -e 's/:.*$//'`
    # Check whether this is an Automake generated Makefile or not.
    # We used to match only the files named 'Makefile.in', but
    # some people rename them; so instead we look at the file content.
    # Grep'ing the first line is not enough: some people post-process
    # each Makefile.in and add a new line on top of each file to say so.
    # Grep'ing the whole file is not good either: AIX grep has a line
    # limit of 2048, but all sed's we know have understand at least 4000.
    if sed -n 's,^#.*generated by automake.*,X,p' "$mf" | grep X >/dev/null 2>&1; then
      dirpart=`AS_DIRNAME("$mf")`
    else
      continue
    fi
    # Extract the definition of DEPDIR, am__include, and am__quote
    # from the Makefile without running 'make'.
    DEPDIR=`sed -n 's/^DEPDIR = //p' < "$mf"`
    test -z "$DEPDIR" && continue
    am__include=`sed -n 's/^am__include = //p' < "$mf"`
    test -z "am__include" && continue
    am__quote=`sed -n 's/^am__quote = //p' < "$mf"`
    # Find all dependency output files, they are included files with
    # $(DEPDIR) in their names.  We invoke sed twice because it is the
    # simplest approach to changing $(DEPDIR) to its actual value in the
    # expansion.
    for file in `sed -n "
      s/^$am__include $am__quote\(.*(DEPDIR).*\)$am__quote"'$/\1/p' <"$mf" | \
	 sed -e 's/\$(DEPDIR)/'"$DEPDIR"'/g'`; do
      # Make sure the directory exists.
      test -f "$dirpart/$file" && continue
      fdir=`AS_DIRNAME(["$file"])`
      AS_MKDIR_P([$dirpart/$fdir])
      # echo "creating $dirpart/$file"
      echo '# dummy' > "$dirpart/$file"
    done
  done
}
])# _AM_OUTPUT_DEPENDENCY_COMMANDS


# AM_OUTPUT_DEPENDENCY_COMMANDS
# -----------------------------
# This macro should only be invoked once -- use via AC_REQUIRE.
#
# This code is only required when automatic dependency tracking
# is enabled.  FIXME.  This creates each '.P' file that we will
# need in order to bootstrap the dependency handling code.
AC_DEFUN([AM_OUTPUT_DEPENDENCY_COMMANDS],
[AC_CONFIG_COMMANDS([depfiles],
     [test x"$AMDEP_TRUE" != x"" || _AM_OUTPUT_DEPENDENCY_COMMANDS],
     [AMDEP_TRUE="$AMDEP_TRUE" ac_aux_dir="$ac_aux_dir"])
])

# Do all the work for Automake.                             -*- Autoconf -*-

# Copyright (C) 1996-2012 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 19

# This macro actually does too much.  Some checks are only needed if
# your package does certain things.  But this isn't really a big deal.

# AM_INIT_AUTOMAKE(PACKAGE, VERSION, [NO-DEFINE])
# AM_INIT_AUTOMAKE([OPTIONS])
# -----------------------------------------------
# The call with PACKAGE and VERSION arguments is the old style
# call (pre autoconf-2.50), which is being phased out.  PACKAGE
# and VERSION should now be passed to AC_INIT and removed from
# the call to AM_INIT_AUTOMAKE.
# We support both call styles for the transition.  After
# the next Automake release, Autoconf can make the AC_INIT
# arguments mandatory, and then we can depend on a new Autoconf
# release and drop the old call support.
AC_DEFUN([AM_INIT_AUTOMAKE],
[AC_PREREQ([2.62])dnl
dnl Autoconf wants to disallow AM_ names.  We explicitly allow
dnl the ones we care about.
m4_pattern_allow([^AM_[A-Z]+FLAGS$])dnl
AC_REQUIRE([AM_SET_CURRENT_AUTOMAKE_VERSION])dnl
AC_REQUIRE([AC_PROG_INSTALL])dnl
if test "`cd $srcdir && pwd`" != "`pwd`"; then
  # Use -I$(srcdir) only when $(srcdir) != ., so that make's output
  # is not polluted with repeated "-I."
  AC_SUBST([am__isrc], [' -I$(srcdir)'])_AM_SUBST_NOTMAKE([am__isrc])dnl
  # test to see if srcdir already configured
  if test -f $srcdir/config.status; then
    AC_MSG_ERROR([source directory already configured; run "make distclean" there first])
  fi
fi

# test whether we have cygpath
if test -z "$CYGPATH_W"; then
  if (cygpath --version) >/dev/null 2>/dev/null; then
    CYGPATH_W='cygpath -w'
  else
    CYGPATH_W=echo
  fi
fi
AC_SUBST([CYGPATH_W])

# Define the identity of the package.
dnl Distinguish between old-style and new-style calls.
m4_ifval([$2],
[AC_DIAGNOSE([obsolete],
[$0: two- and three-arguments forms are deprecated.  For more info, see:
http://www.gnu.org/software/automake/manual/automake.html#Modernize-AM_INIT_AUTOMAKE-invocation])
m4_ifval([$3], [_AM_SET_OPTION([no-define])])dnl
 AC_SUBST([PACKAGE], [$1])dnl
 AC_SUBST([VERSION], [$2])],
[_AM_SET_OPTIONS([$1])dnl
dnl Diagnose old-style AC_INIT with new-style AM_AUTOMAKE_INIT.
m4_if(
  m4_ifdef([AC_PACKAGE_NAME], [ok]):m4_ifdef([AC_PACKAGE_VERSION], [ok]),
  [ok:ok],,
  [m4_fatal([AC_INIT should be called with package and version arguments])])dnl
 AC_SUBST([PACKAGE], ['AC_PACKAGE_TARNAME'])dnl
 AC_SUBST([VERSION], ['AC_PACKAGE_VERSION'])])dnl

_AM_IF_OPTION([no-define],,
[AC_DEFINE_UNQUOTED([PACKAGE], ["$PACKAGE"], [Name of package])
 AC_DEFINE_UNQUOTED([VERSION], ["$VERSION"], [Version number of package])])dnl

# Some tools Automake needs.
AC_REQUIRE([AM_SANITY_CHECK])dnl
AC_REQUIRE([AC_ARG_PROGRAM])dnl
AM_MISSING_PROG([ACLOCAL], [aclocal-${am__api_version}])
AM_MISSING_PROG([AUTOCONF], [autoconf])
AM_MISSING_PROG([AUTOMAKE], [automake-${am__api_version}])
AM_MISSING_PROG([AUTOHEADER], [autoheader])
AM_MISSING_PROG([MAKEINFO], [makeinfo])
AC_REQUIRE([AM_PROG_INSTALL_SH])dnl
AC_REQUIRE([AM_PROG_INSTALL_STRIP])dnl
AC_REQUIRE([AC_PROG_MKDIR_P])dnl
# For better backward compatibility.  To be removed once Automake 1.9.x
# dies out for good.  For more background, see:
# <http://lists.gnu.org/archive/html/automake/2012-07/msg00001.html>
# <http://lists.gnu.org/archive/html/automake/2012-07/msg00014.html>
AC_SUBST([mkdir_p], ['$(MKDIR_P)'])
# We need awk for the "check" target.  The system "awk" is bad on
# some platforms.
AC_REQUIRE([AC_PROG_AWK])dnl
AC_REQUIRE([AC_PROG_MAKE_SET])dnl
AC_REQUIRE([AM_SET_LEADING_DOT])dnl
_AM_IF_OPTION([tar-ustar], [_AM_PROG_TAR([ustar])],
	      [_AM_IF_OPTION([tar-pax], [_AM_PROG_TAR([pax])],
			     [_AM_PROG_TAR([v7])])])
_AM_IF_OPTION([no-dependencies],,
[AC_PROVIDE_IFELSE([AC_PROG_CC],
		  [_AM_DEPENDENCIES([CC])],
		  [m4_define([AC_PROG_CC],
			     m4_defn([AC_PROG_CC])[_AM_DEPENDENCIES([CC])])])dnl
AC_PROVIDE_IFELSE([AC_PROG_CXX],
		  [_AM_DEPENDENCIES([CXX])],
		  [m4_define([AC_PROG_CXX],
			     m4_defn([AC_PROG_CXX])[_AM_DEPENDENCIES([CXX])])])dnl
AC_PROVIDE_IFELSE([AC_PROG_OBJC],
		  [_AM_DEPENDENCIES([OBJC])],
		  [m4_define([AC_PROG_OBJC],
			     m4_defn([AC_PROG_OBJC])[_AM_DEPENDENCIES([OBJC])])])dnl
dnl Support for Objective C++ was only introduced in Autoconf 2.65,
dnl but we still cater to Autoconf 2.62.
m4_ifdef([AC_PROG_OBJCXX],
[AC_PROVIDE_IFELSE([AC_PROG_OBJCXX],
		  [_AM_DEPENDENCIES([OBJCXX])],
		  [m4_define([AC_PROG_OBJCXX],
			     m4_defn([AC_PROG_OBJCXX])[_AM_DEPENDENCIES([OBJCXX])])])])dnl
])
_AM_IF_OPTION([silent-rules], [AC_REQUIRE([AM_SILENT_RULES])])dnl
dnl The 'parallel-tests' driver may need to know about EXEEXT, so add the
dnl 'am__EXEEXT' conditional if _AM_COMPILER_EXEEXT was seen.  This macro
dnl is hooked onto _AC_COMPILER_EXEEXT early, see below.
AC_CONFIG_COMMANDS_PRE(dnl
[m4_provide_if([_AM_COMPILER_EXEEXT],
  [AM_CONDITIONAL([am__EXEEXT], [test -n "$EXEEXT"])])])dnl
])

dnl Hook into '_AC_COMPILER_EXEEXT' early to learn its expansion.  Do not
dnl add the conditional right here, as _AC_COMPILER_EXEEXT may be further
dnl mangled by Autoconf and run in a shell conditional statement.
m4_define([_AC_COMPILER_EXEEXT],
m4_defn([_AC_COMPILER_EXEEXT])[m4_provide([_AM_COMPILER_EXEEXT])])


# When config.status generates a header, we must update the stamp-h file.
# This file resides in the same directory as the config header
# that is generated.  The stamp files are numbered to have different names.

# Autoconf calls _AC_AM_CONFIG_HEADER_HOOK (when defined) in the
# loop where config.status creates the headers, so we can generate
# our stamp files there.
AC_DEFUN([_AC_AM_CONFIG_HEADER_HOOK],
[# Compute $1's index in $config_headers.
_am_arg=$1
_am_stamp_count=1
for _am_header in $config_headers :; do
  case $_am_header in
    $_am_arg | $_am_arg:* )
      break ;;
    * )
      _am_stamp_count=`expr $_am_stamp_count + 1` ;;
  esac
done
echo "timestamp for $_am_arg" >`AS_DIRNAME(["$_am_arg"])`/stamp-h[]$_am_stamp_count])

# Copyright (C) 2001-2012 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 8

# AM_PROG_INSTALL_SH
# ------------------
# Define $install_sh.
AC_DEFUN([AM_PROG_INSTALL_SH],
[AC_REQUIRE([AM_AUX_DIR_EXPAND])dnl
if test x"${install_sh}" != xset; then
  case $am_aux_dir in
  *\ * | *\	*)
    install_sh="\${SHELL} '$am_aux_dir/install-sh'" ;;
  *)
    install_sh="\${SHELL} $am_aux_dir/install-sh"
  esac
fi
AC_SUBST([install_sh])])

# Copyright (C) 2003-2012 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 2

# Check whether the underlying file-system supports filenames
# with a leading dot.  For instance MS-DOS doesn't.
AC_DEFUN([AM_SET_LEADING_DOT],
[rm -rf .tst 2>/dev/null
mkdir .tst 2>/dev/null
if test -d .tst; then
  am__leading_dot=.
else
  am__leading_dot=_
fi
rmdir .tst 2>/dev/null
AC_SUBST([am__leading_dot])])

# Add --enable-maintainer-mode option to configure.         -*- Autoconf -*-
# From Jim Meyering

# Copyright (C) 1996-2012 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 7

# AM_MAINTAINER_MODE([DEFAULT-MODE])
# ----------------------------------
# Control maintainer-specific portions of Makefiles.
# Default is to disable them, unless 'enable' is passed literally.
# For symmetry, 'disable' may be passed as well.  Anyway, the user
# can override the default with the --enable/--disable switch.
AC_DEFUN([AM_MAINTAINER_MODE],
[m4_case(m4_default([$1], [disable]),
       [enable], [m4_define([am_maintainer_other], [disable])],
       [disable], [m4_define([am_maintainer_other], [enable])],
       [m4_define([am_maintainer_other], [enable])
        m4_warn([syntax], [unexpected argument to AM@&t@_MAINTAINER_MODE: $1])])
AC_MSG_CHECKING([whether to enable maintainer-specific portions of Makefiles])
  dnl maintainer-mode's default is 'disable' unless 'enable' is passed
  AC_ARG_ENABLE([maintainer-mode],
    [AS_HELP_STRING([--]am_maintainer_other[-maintainer-mode],
      am_maintainer_other[ make rules and dependencies not useful
      (and sometimes confusing) to the casual installer])],
    [USE_MAINTAINER_MODE=$enableval],
    [USE_MAINTAINER_MODE=]m4_if(am_maintainer_other, [enable], [no], [yes]))
  AC_MSG_RESULT([$USE_MAINTAINER_MODE])
  AM_CONDITIONAL([MAINTAINER_MODE], [test $USE_MAINTAINER_MODE = yes])
  MAINT=$MAINTAINER_MODE_TRUE
  AC_SUBST([MAINT])dnl
]
)

AU_DEFUN([jm_MAINTAINER_MODE], [AM_MAINTAINER_MODE])

# Check to see how 'make' treats includes.	            -*- Autoconf -*-

# Copyright (C) 2001-2012 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 5

# AM_MAKE_INCLUDE()
# -----------------
# Check to see how make treats includes.
AC_DEFUN([AM_MAKE_INCLUDE],
[am_make=${MAKE-make}
cat > confinc << 'END'
am__doit:
	@echo this is the am__doit target
.PHONY: am__doit
END
# If we don't find an include directive, just comment out the code.
AC_MSG_CHECKING([for style of include used by $am_make])
am__include="#"
am__quote=
_am_result=none
# First try GNU make style include.
echo "include confinc" > confmf
# Ignore all kinds of additional output from 'make'.
case `$am_make -s -f confmf 2> /dev/null` in #(
*the\ am__doit\ target*)
  am__include=include
  am__quote=
  _am_result=GNU
  ;;
esac
# Now try BSD make style include.
if test "$am__include" = "#"; then
   echo '.include "confinc"' > confmf
   case `$am_make -s -f confmf 2> /dev/null` in #(
   *the\ am__doit\ target*)
     am__include=.include
     am__quote="\""
     _am_result=BSD
     ;;
   esac
fi
AC_SUBST([am__include])
AC_SUBST([am__quote])
AC_MSG_RESULT([$_am_result])
rm -f confinc confmf
])

# Fake the existence of programs that GNU maintainers use.  -*- Autoconf -*-

# Copyright (C) 1997-2012 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 7

# AM_MISSING_PROG(NAME, PROGRAM)
# ------------------------------
AC_DEFUN([AM_MISSING_PROG],
[AC_REQUIRE([AM_MISSING_HAS_RUN])
$1=${$1-"${am_missing_run}$2"}
AC_SUBST($1)])


# AM_MISSING_HAS_RUN
# ------------------
# Define MISSING if not defined so far and test if it supports --run.
# If it does, set am_missing_run to use it, otherwise, to nothing.
AC_DEFUN([AM_MISSING_HAS_RUN],
[AC_REQUIRE([AM_AUX_DIR_EXPAND])dnl
AC_REQUIRE_AUX_FILE([missing])dnl
if test x"${MISSING+set}" != xset; then
  case $am_aux_dir in
  *\ * | *\	*)
    MISSING="\${SHELL} \"$am_aux_dir/missing\"" ;;
  *)
    MISSING="\${SHELL} $am_aux_dir/missing" ;;
  esac
fi
# Use eval to expand $SHELL
if eval "$MISSING --run true"; then
  am_missing_run="$MISSING --run "
else
  am_missing_run=
  AC_MSG_WARN(['missing' script is too old or missing])
fi
])

# Helper functions for option handling.                     -*- Autoconf -*-

# Copyright (C) 2001-2012 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 6

# _AM_MANGLE_OPTION(NAME)
# -----------------------
AC_DEFUN([_AM_MANGLE_OPTION],
[[_AM_OPTION_]m4_bpatsubst($1, [[^a-zA-Z0-9_]], [_])])

# _AM_SET_OPTION(NAME)
# --------------------
# Set option NAME.  Presently that only means defining a flag for this option.
AC_DEFUN([_AM_SET_OPTION],
[m4_define(_AM_MANGLE_OPTION([$1]), [1])])

# _AM_SET_OPTIONS(OPTIONS)
# ------------------------
# OPTIONS is a space-separated list of Automake options.
AC_DEFUN([_AM_SET_OPTIONS],
[m4_foreach_w([_AM_Option], [$1], [_AM_SET_OPTION(_AM_Option)])])

# _AM_IF_OPTION(OPTION, IF-SET, [IF-NOT-SET])
# -------------------------------------------
# Execute IF-SET if OPTION is set, IF-NOT-SET otherwise.
AC_DEFUN([_AM_IF_OPTION],
[m4_ifset(_AM_MANGLE_OPTION([$1]), [$2], [$3])])

# Copyright (C) 2001-2012 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 1

# AM_RUN_LOG(COMMAND)
# -------------------
# Run COMMAND, save the exit status in ac_status, and log it.
# (This has been adapted from Autoconf's _AC_RUN_LOG macro.)
AC_DEFUN([AM_RUN_LOG],
[{ echo "$as_me:$LINENO: $1" >&AS_MESSAGE_LOG_FD
   ($1) >&AS_MESSAGE_LOG_FD 2>&AS_MESSAGE_LOG_FD
   ac_status=$?
   echo "$as_me:$LINENO: \$? = $ac_status" >&AS_MESSAGE_LOG_FD
   (exit $ac_status); }])

# Check to make sure that the build environment is sane.    -*- Autoconf -*-

# Copyright (C) 1996-2012 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 9

# AM_SANITY_CHECK
# ---------------
AC_DEFUN([AM_SANITY_CHECK],
[AC_MSG_CHECKING([whether build environment is sane])
# Reject unsafe characters in $srcdir or the absolute working directory
# name.  Accept space and tab only in the latter.
am_lf='
'
case `pwd` in
  *[[\\\"\#\$\&\'\`$am_lf]]*)
    AC_MSG_ERROR([unsafe absolute working directory name]);;
esac
case $srcdir in
  *[[\\\"\#\$\&\'\`$am_lf\ \	]]*)
    AC_MSG_ERROR([unsafe srcdir value: '$srcdir']);;
esac

# Do 'set' in a subshell so we don't clobber the current shell's
# arguments.  Must try -L first in case configure is actually a
# symlink; some systems play weird games with the mod time of symlinks
# (eg FreeBSD returns the mod time of the symlink's containing
# directory).
if (
   am_has_slept=no
   for am_try in 1 2; do
     echo "timestamp, slept: $am_has_slept" > conftest.file
     set X `ls -Lt "$srcdir/configure" conftest.file 2> /dev/null`
     if test "$[*]" = "X"; then
	# -L didn't work.
	set X `ls -t "$srcdir/configure" conftest.file`
     fi
     if test "$[*]" != "X $srcdir/configure conftest.file" \
	&& test "$[*]" != "X conftest.file $srcdir/configure"; then

	# If neither matched, then we have a broken ls.  This can happen
	# if, for instance, CONFIG_SHELL is bash and it inherits a
	# broken ls alias from the environment.  This has actually
	# happened.  Such a system could not be considered "sane".
	AC_MSG_ERROR([ls -t appears to fail.  Make sure there is not a broken
  alias in your environment])
     fi
     if test "$[2]" = conftest.file || test $am_try -eq 2; then
       break
     fi
     # Just in case.
     sleep 1
     am_has_slept=yes
   done
   test "$[2]" = conftest.file
   )
then
   # Ok.
   :
else
   AC_MSG_ERROR([newly created file is older than distributed files!
Check your system clock])
fi
AC_MSG_RESULT([yes])
# If we didn't sleep, we still need to ensure time stamps of config.status and
# generated files are strictly newer.
am_sleep_pid=
if grep 'slept: no' conftest.file >/dev/null 2>&1; then
  ( sleep 1 ) &
  am_sleep_pid=$!
fi
AC_CONFIG_COMMANDS_PRE(
  [AC_MSG_CHECKING([that generated files are newer than configure])
   if test -n "$am_sleep_pid"; then
     # Hide warnings about reused PIDs.
     wait $am_sleep_pid 2>/dev/null
   fi
   AC_MSG_RESULT([done])])
rm -f conftest.file
])

# Copyright (C) 2001-2012 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 2

# AM_PROG_INSTALL_STRIP
# ---------------------
# One issue with vendor 'install' (even GNU) is that you can't
# specify the program used to strip binaries.  This is especially
# annoying in cross-compiling environments, where the build's strip
# is unlikely to handle the host's binaries.
# Fortunately install-sh will honor a STRIPPROG variable, so we
# always use install-sh in "make install-strip", and initialize
# STRIPPROG with the value of the STRIP variable (set by the user).
AC_DEFUN([AM_PROG_INSTALL_STRIP],
[AC_REQUIRE([AM_PROG_INSTALL_SH])dnl
# Installed binaries are usually stripped using 'strip' when the user
# run "make install-strip".  However 'strip' might not be the right
# tool to use in cross-compilation environments, therefore Automake
# will honor the 'STRIP' environment variable to overrule this program.
dnl Don't test for $cross_compiling = yes, because it might be 'maybe'.
if test "$cross_compiling" != no; then
  AC_CHECK_TOOL([STRIP], [strip], :)
fi
INSTALL_STRIP_PROGRAM="\$(install_sh) -c -s"
AC_SUBST([INSTALL_STRIP_PROGRAM])])

# Copyright (C) 2006-2012 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 3

# _AM_SUBST_NOTMAKE(VARIABLE)
# ---------------------------
# Prevent Automake from outputting VARIABLE = @VARIABLE@ in Makefile.in.
# This macro is traced by Automake.
AC_DEFUN([_AM_SUBST_NOTMAKE])

# AM_SUBST_NOTMAKE(VARIABLE)
# --------------------------
# Public sister of _AM_SUBST_NOTMAKE.
AC_DEFUN([AM_SUBST_NOTMAKE], [_AM_SUBST_NOTMAKE($@)])

# Check how to create a tarball.                            -*- Autoconf -*-

# Copyright (C) 2004-2012 Free Software Foundation, Inc.
#
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# serial 3

# _AM_PROG_TAR(FORMAT)
# --------------------
# Check how to create a tarball in format FORMAT.
# FORMAT should be one of 'v7', 'ustar', or 'pax'.
#
# Substitute a variable $(am__tar) that is a command
# writing to stdout a FORMAT-tarball containing the directory
# $tardir.
#     tardir=directory && $(am__tar) > result.tar
#
# Substitute a variable $(am__untar) that extract such
# a tarball read from stdin.
#     $(am__untar) < result.tar
AC_DEFUN([_AM_PROG_TAR],
[# Always define AMTAR for backward compatibility.  Yes, it's still used
# in the wild :-(  We should find a proper way to deprecate it ...
AC_SUBST([AMTAR], ['$${TAR-tar}'])
m4_if([$1], [v7],
     [am__tar='$${TAR-tar} chof - "$$tardir"' am__untar='$${TAR-tar} xf -'],
     [m4_case([$1], [ustar],, [pax],,
              [m4_fatal([Unknown tar format])])
AC_MSG_CHECKING([how to create a $1 tar archive])
# Loop over all known methods to create a tar archive until one works.
_am_tools='gnutar m4_if([$1], [ustar], [plaintar]) pax cpio none'
_am_tools=${am_cv_prog_tar_$1-$_am_tools}
# Do not fold the above two line into one, because Tru64 sh and
# Solaris sh will not grok spaces in the rhs of '-'.
for _am_tool in $_am_tools
do
  case $_am_tool in
  gnutar)
    for _am_tar in tar gnutar gtar;
    do
      AM_RUN_LOG([$_am_tar --version]) && break
    done
    am__tar="$_am_tar --format=m4_if([$1], [pax], [posix], [$1]) -chf - "'"$$tardir"'
    am__tar_="$_am_tar --format=m4_if([$1], [pax], [posix], [$1]) -chf - "'"$tardir"'
    am__untar="$_am_tar -xf -"
    ;;
  plaintar)
    # Must skip GNU tar: if it does not support --format= it doesn't create
    # ustar tarball either.
    (tar --version) >/dev/null 2>&1 && continue
    am__tar='tar chf - "$$tardir"'
    am__tar_='tar chf - "$tardir"'
    am__untar='tar xf -'
    ;;
  pax)
    am__tar='pax -L -x $1 -w "$$tardir"'
    am__tar_='pax -L -x $1 -w "$tardir"'
    am__untar='pax -r'
    ;;
  cpio)
    am__tar='find "$$tardir" -print | cpio -o -H $1 -L'
    am__tar_='find "$tardir" -print | cpio -o -H $1 -L'
    am__untar='cpio -i -H $1 -d'
    ;;
  none)
    am__tar=false
    am__tar_=false
    am__untar=false
    ;;
  esac

  # If the value was cached, stop now.  We just wanted to have am__tar
  # and am__untar set.
  test -n "${am_cv_prog_tar_$1}" && break

  # tar/untar a dummy directory, and stop if the command works
  rm -rf conftest.dir
  mkdir conftest.dir
  echo GrepMe > conftest.dir/file
  AM_RUN_LOG([tardir=conftest.dir && eval $am__tar_ >conftest.tar])
  rm -rf conftest.dir
  if test -s conftest.tar; then
    AM_RUN_LOG([$am__untar <conftest.tar])
    grep GrepMe conftest.dir/file >/dev/null 2>&1 && break
  fi
done
rm -rf conftest.dir

AC_CACHE_VAL([am_cv_prog_tar_$1], [am_cv_prog_tar_$1=$_am_tool])
AC_MSG_RESULT([$am_cv_prog_tar_$1])])
AC_SUBST([am__tar])
AC_SUBST([am__untar])
]) # _AM_PROG_TAR

#
# LS_CONFIGURE
#
# configure bits for lustre-snmp
#
AC_DEFUN([LS_CONFIGURE],
[AC_MSG_CHECKING([whether to try to build SNMP support])
AC_ARG_ENABLE([snmp],
	AC_HELP_STRING([--enable-snmp],
		       [require SNMP support (default=auto)]),
	[],[enable_snmp='auto'])
AC_MSG_RESULT([$enable_snmp])

if test x$enable_snmp != xno ; then
	AC_CHECK_PROG([NET_SNMP_CONFIG], [net-snmp-config], [net-snmp-config])
	if test "$NET_SNMP_CONFIG" ; then
		NET_SNMP_CFLAGS=$($NET_SNMP_CONFIG --base-cflags)
		NET_SNMP_LIBS=$($NET_SNMP_CONFIG --agent-libs)

		CPPFLAGS_save="$CPPFLAGS"
		CPPFLAGS="$CPPFLAGS $NET_SNMP_CFLAGS"

		LIBS_save="$LIBS"
		LIBS="$LIBS $NET_SNMP_LIBS"

		AC_CHECK_HEADER([net-snmp/net-snmp-config.h],[
			AC_CHECK_FUNC([register_mib],[SNMP_SUBDIR="snmp"],[
				LIBS="$LIBS -lwrap"
				NET_SNMP_LISB="$NET_SNMP_LIBS -lwrap"
				# fail autoconf's cache
				unset ac_cv_func_register_mib
				AC_CHECK_FUNC([register_mib],[SNMP_SUBDIR="snmp"])
			])
		])

		LIBS="$LIBS_save"
		CPPFLAGS="$CPPFLAGS_save"
	fi
	AC_MSG_CHECKING([for SNMP support])
	if test "$SNMP_SUBDIR" ; then
		AC_MSG_RESULT([yes])
	else
		AC_MSG_RESULT([no (see config.log for errors)])
		if test x$enable_snmp = xyes ; then
			AC_MSG_ERROR([SNMP support was requested, but unavailable])
		fi
	fi
fi

agentdir='${pkglibdir}/snmp'
mibdir='${pkgdatadir}/snmp/mibs'

AC_SUBST(NET_SNMP_CFLAGS)
AC_SUBST(NET_SNMP_LIBS)
AC_SUBST(agentdir)
AC_SUBST(mibdir)
])

#
# LS_CONFIG_FILE
#
# files that should be generated with AC_OUTPUT
#
AC_DEFUN([LS_CONFIG_FILES],
[AC_CONFIG_FILES([
snmp/Makefile
snmp/autoconf/Makefile
])
])

dnl Checks for Kerberos
dnl NOTE: while we intend to do generic gss-api, currently we
dnl have a requirement to get an initial Kerberos machine
dnl credential.  Thus, the requirement for Kerberos.
dnl The Kerberos gssapi library will be dynamically loaded?
AC_DEFUN([AC_KERBEROS_V5],[
  AC_MSG_CHECKING(for Kerberos v5)
  AC_ARG_WITH(krb5,
  [AC_HELP_STRING([--with-krb5=DIR], [use Kerberos v5 installation in DIR])],
  [ case "$withval" in
    yes|no)
       krb5_with=""
       ;;
    *)
       krb5_with="$withval"
       ;;
    esac ]
  )

  for dir in $krb5_with /usr /usr/kerberos /usr/local /usr/local/krb5 \
  	     /usr/krb5 /usr/heimdal /usr/local/heimdal /usr/athena ; do
    dnl This ugly hack brought on by the split installation of
    dnl MIT Kerberos on Fedora Core 1
    K5CONFIG=""
    if test -f $dir/bin/krb5-config; then
      K5CONFIG=$dir/bin/krb5-config
    elif test -f "/usr/kerberos/bin/krb5-config"; then
      K5CONFIG="/usr/kerberos/bin/krb5-config"
    elif test -f "/usr/lib/mit/bin/krb5-config"; then
      K5CONFIG="/usr/lib/mit/bin/krb5-config"
    fi
    if test "$K5CONFIG" != ""; then
      KRBCFLAGS=`$K5CONFIG --cflags`
      KRBLIBS=`$K5CONFIG --libs gssapi`
      K5VERS=`$K5CONFIG --version | head -n 1 | awk '{split($(4),v,"."); if (v@<:@"3"@:>@ == "") v@<:@"3"@:>@ = "0"; print v@<:@"1"@:>@v@<:@"2"@:>@v@<:@"3"@:>@ }'`
      AC_DEFINE_UNQUOTED(KRB5_VERSION, $K5VERS, [Define this as the Kerberos version number])
      if test -f $dir/include/gssapi/gssapi_krb5.h -a \
                \( -f $dir/lib/libgssapi_krb5.a -o \
                   -f $dir/lib64/libgssapi_krb5.a -o \
                   -f $dir/lib64/libgssapi_krb5.so -o \
                   -f $dir/lib/x86_64-linux-gnu/libgssapi_krb5.so -o \
                   -f $dir/lib/libgssapi_krb5.so \) ; then
         AC_DEFINE(HAVE_KRB5, 1, [Define this if you have MIT Kerberos libraries])
         KRBDIR="$dir"
  dnl If we are using MIT K5 1.3.1 and before, we *MUST* use the
  dnl private function (gss_krb5_ccache_name) to get correct
  dnl behavior of changing the ccache used by gssapi.
  dnl Starting in 1.3.2, we *DO NOT* want to use
  dnl gss_krb5_ccache_name, instead we want to set KRB5CCNAME
  dnl to get gssapi to use a different ccache
         if test $K5VERS -le 131; then
           AC_DEFINE(USE_GSS_KRB5_CCACHE_NAME, 1, [Define this if the private function, gss_krb5_cache_name, must be used to tell the Kerberos library which credentials cache to use. Otherwise, this is done by setting the KRB5CCNAME environment variable])
         fi
         gssapi_lib=gssapi_krb5
         break
      dnl The following ugly hack brought on by the split installation
      dnl of Heimdal Kerberos on SuSe
      elif test \( -f $dir/include/heim_err.h -o\
      		 -f $dir/include/heimdal/heim_err.h \) -a \
                -f $dir/lib/libroken.a; then
         AC_DEFINE(HAVE_HEIMDAL, 1, [Define this if you have Heimdal Kerberos libraries])
         KRBDIR="$dir"
         gssapi_lib=gssapi
        break
      fi
    fi
  done
  dnl We didn't find a usable Kerberos environment
  if test "x$KRBDIR" = "x"; then
    if test "x$krb5_with" = "x"; then
      AC_MSG_ERROR(Kerberos v5 with GSS support not found: consider --disable-gss or --with-krb5=)
    else
      AC_MSG_ERROR(Kerberos v5 with GSS support not found at $krb5_with)
    fi
  fi
  AC_MSG_RESULT($KRBDIR)

  dnl Check if -rpath=$(KRBDIR)/lib is needed
  echo "The current KRBDIR is $KRBDIR"
  if test "$KRBDIR/lib" = "/lib" -o "$KRBDIR/lib" = "/usr/lib" \
       -o "$KRBDIR/lib" = "//lib" -o "$KRBDIR/lib" = "/usr//lib" ; then
    KRBLDFLAGS="";
  elif /sbin/ldconfig -p | grep > /dev/null "=> $KRBDIR/lib/"; then
    KRBLDFLAGS="";
  else
    KRBLDFLAGS="-Wl,-rpath=$KRBDIR/lib"
  fi

  dnl Now check for functions within gssapi library
  AC_CHECK_LIB($gssapi_lib, gss_krb5_export_lucid_sec_context,
    AC_DEFINE(HAVE_LUCID_CONTEXT_SUPPORT, 1, [Define this if the Kerberos GSS library supports gss_krb5_export_lucid_sec_context]), ,$KRBLIBS)
  AC_CHECK_LIB($gssapi_lib, gss_krb5_set_allowable_enctypes,
    AC_DEFINE(HAVE_SET_ALLOWABLE_ENCTYPES, 1, [Define this if the Kerberos GSS library supports gss_krb5_set_allowable_enctypes]), ,$KRBLIBS)
  AC_CHECK_LIB($gssapi_lib, gss_krb5_ccache_name,
    AC_DEFINE(HAVE_GSS_KRB5_CCACHE_NAME, 1, [Define this if the Kerberos GSS library supports gss_krb5_ccache_name]), ,$KRBLIBS)

  dnl Check for newer error message facility
  AC_CHECK_LIB($gssapi_lib, krb5_get_error_message,
    AC_DEFINE(HAVE_KRB5_GET_ERROR_MESSAGE, 1, [Define this if the function krb5_get_error_message is available]), ,$KRBLIBS)

  dnl Check for function to specify addressless tickets
  AC_CHECK_LIB($gssapi_lib, krb5_get_init_creds_opt_set_addressless,
    AC_DEFINE(HAVE_KRB5_GET_INIT_CREDS_OPT_SET_ADDRESSLESS, 1, [Define this if the function krb5_get_init_creds_opt_set_addressless is available]), ,$KRBLIBS)

  dnl Check for krb5int_derive_key
  AC_CHECK_LIB($gssapi_lib, krb5int_derive_key,
    AC_DEFINE(HAVE_KRB5INT_DERIVE_KEY, 1, [Define this if the function krb5int_derive_key is available]), ,$KRBLIBS)

  dnl If they specified a directory and it didn't work, give them a warning
  if test "x$krb5_with" != "x" -a "$krb5_with" != "$KRBDIR"; then
    AC_MSG_WARN(Using $KRBDIR instead of requested value of $krb5_with for Kerberos!)
  fi

  AC_SUBST([KRBDIR])
  AC_SUBST([KRBLIBS])
  AC_SUBST([KRBCFLAGS])
  AC_SUBST([KRBLDFLAGS])
  AC_SUBST([K5VERS])

])

#
# LC_CONFIG_SRCDIR
#
# Wrapper for AC_CONFIG_SUBDIR
#
AC_DEFUN([LC_CONFIG_SRCDIR],
[AC_CONFIG_SRCDIR([lustre/obdclass/obdo.c])
libcfs_is_module=yes
ldiskfs_is_ext4=yes
])

#
# LC_PATH_DEFAULTS
#
# lustre specific paths
#
AC_DEFUN([LC_PATH_DEFAULTS],
[# ptlrpc kernel build requires this
LUSTRE="$PWD/lustre"
AC_SUBST(LUSTRE)

# mount.lustre
rootsbindir='$(CROSS_PATH)/sbin'
AC_SUBST(rootsbindir)

demodir='$(docdir)/demo'
AC_SUBST(demodir)

pkgexampledir='${pkgdatadir}/examples'
AC_SUBST(pkgexampledir)
])

#
# LC_TARGET_SUPPORTED
#
# is the target os supported?
#
AC_DEFUN([LC_TARGET_SUPPORTED],
[case $target_os in
	linux* | darwin*)
$1
		;;
	*)
$2
		;;
esac
])

#
# LC_CONFIG_OBD_BUFFER_SIZE
#
# the maximum buffer size of lctl ioctls
#
AC_DEFUN([LC_CONFIG_OBD_BUFFER_SIZE],
[AC_MSG_CHECKING([maximum OBD ioctl size])
AC_ARG_WITH([obd-buffer-size],
	AC_HELP_STRING([--with-obd-buffer-size=[size]],
			[set lctl ioctl maximum bytes (default=8192)]),
	[
		OBD_BUFFER_SIZE=$with_obd_buffer_size
	],[
		OBD_BUFFER_SIZE=8192
	])
AC_MSG_RESULT([$OBD_BUFFER_SIZE bytes])
AC_DEFINE_UNQUOTED(OBD_MAX_IOCTL_BUFFER, $OBD_BUFFER_SIZE, [IOCTL Buffer Size])
])

#
# LC_READLINK_SSIZE_T
#
AC_DEFUN([LC_READLINK_SSIZE_T],
[AC_MSG_CHECKING([if readlink returns ssize_t])
AC_TRY_COMPILE([
	#include <unistd.h>
],[
	ssize_t readlink(const char *, char *, size_t);
],[
	AC_MSG_RESULT([yes])
	AC_DEFINE(HAVE_POSIX_1003_READLINK, 1, [readlink returns ssize_t])
],[
	AC_MSG_RESULT([no])
])
])

#
# LC_FUNC_DEV_SET_RDONLY
#
# check whether dev_set_rdonly is exported.  This is needed until we
# have another mechanism to fence IO from the underlying device.
#
AC_DEFUN([LC_FUNC_DEV_SET_RDONLY],
[LB_CHECK_SYMBOL_EXPORT([dev_set_rdonly],
[block/ll_rw_block.c,block/blk-core.c],[
        AC_DEFINE(HAVE_DEV_SET_RDONLY, 1, [kernel exports dev_set_rdonly])
],[
        AC_MSG_WARN([kernel missing dev_set_rdonly patch for testing])
])
])

#
# Ensure stack size big than 8k in Lustre server (all kernels)
#
AC_DEFUN([LC_STACK_SIZE],
[AC_MSG_CHECKING([stack size big than 8k])
LB_LINUX_TRY_COMPILE([
	#include <linux/thread_info.h>
],[
        #if THREAD_SIZE < 8192
        #error "stack size < 8192"
        #endif
],[
        AC_MSG_RESULT(yes)
],[
        AC_MSG_ERROR([Lustre requires that Linux is configured with at least a 8KB stack.])
])
])

#
# Allow the user to set the MDS thread upper limit
#
AC_DEFUN([LC_MDS_MAX_THREADS],
[
	AC_ARG_WITH([mds_max_threads],
	AC_HELP_STRING([--with-mds-max-threads=count],
		       [maximum threads available on the MDS: (default=512)]),
	[
		MDS_THREAD_COUNT=$with_mds_max_threads
		AC_DEFINE_UNQUOTED(MDS_MAX_THREADS, $MDS_THREAD_COUNT, [maximum number of MDS threads])
	])
])

#
# LC_CONFIG_PINGER
#
# the pinger is temporary, until we have the recovery node in place
#
AC_DEFUN([LC_CONFIG_PINGER],
[AC_MSG_CHECKING([whether to enable pinger support])
AC_ARG_ENABLE([pinger],
	AC_HELP_STRING([--disable-pinger],
			[disable recovery pinger support]),
	[],[enable_pinger='yes'])
AC_MSG_RESULT([$enable_pinger])
if test x$enable_pinger != xno ; then
  AC_DEFINE(ENABLE_PINGER, 1, Use the Pinger)
fi
])

#
# LC_CONFIG_CHECKSUM
#
# do checksum of bulk data between client and OST
#
AC_DEFUN([LC_CONFIG_CHECKSUM],
[AC_MSG_CHECKING([whether to enable data checksum support])
AC_ARG_ENABLE([checksum],
       AC_HELP_STRING([--disable-checksum],
                       [disable data checksum support]),
       [],[enable_checksum='yes'])
AC_MSG_RESULT([$enable_checksum])
if test x$enable_checksum != xno ; then
  AC_DEFINE(ENABLE_CHECKSUM, 1, do data checksums)
fi
])

#
# LC_CONFIG_LIBLUSTRE_RECOVERY
#
AC_DEFUN([LC_CONFIG_LIBLUSTRE_RECOVERY],
[AC_MSG_CHECKING([whether to enable liblustre recovery support])
AC_ARG_ENABLE([liblustre-recovery],
	AC_HELP_STRING([--disable-liblustre-recovery],
			[disable liblustre recovery support]),
	[],[enable_liblustre_recovery='yes'])
AC_MSG_RESULT([$enable_liblustre_recovery])
if test x$enable_liblustre_recovery != xno ; then
  AC_DEFINE(ENABLE_LIBLUSTRE_RECOVERY, 1, Liblustre Can Recover)
fi
])

#
# LC_CONFIG_HEALTH_CHECK_WRITE
#
# Turn off the actual write to the disk
#
AC_DEFUN([LC_CONFIG_HEALTH_CHECK_WRITE],
[AC_MSG_CHECKING([whether to enable a write with the health check])
AC_ARG_ENABLE([health_write],
        AC_HELP_STRING([--enable-health_write],
                        [enable disk writes when doing health check]),
        [],[enable_health_write='no'])
AC_MSG_RESULT([$enable_health_write])
if test x$enable_health_write != xno ; then
  AC_DEFINE(USE_HEALTH_CHECK_WRITE, 1, Write when Checking Health)
fi
])

AC_DEFUN([LC_CONFIG_LRU_RESIZE],
[AC_MSG_CHECKING([whether to enable lru self-adjusting])
AC_ARG_ENABLE([lru_resize],
	AC_HELP_STRING([--enable-lru-resize],
			[enable lru resize support]),
	[],[enable_lru_resize='yes'])
AC_MSG_RESULT([$enable_lru_resize])
if test x$enable_lru_resize != xno; then
   AC_DEFINE(HAVE_LRU_RESIZE_SUPPORT, 1, [Enable lru resize support])
fi
])

#
# Quota support. The kernel must support CONFIG_QUOTA.
#
AC_DEFUN([LC_QUOTA_CONFIG],
[LB_LINUX_CONFIG_IM([QUOTA],[],[
        AC_MSG_ERROR([Lustre quota requires that CONFIG_QUOTA is enabled in your kernel.])
	])
])

# truncate_complete_page() was exported from RHEL5/SLES10, but not in SLES11 SP0 (2.6.27)
# remove_from_page_cache() was exported between 2.6.35 and 2.6.38
# delete_from_page_cache() is exported from 2.6.39
AC_DEFUN([LC_EXPORT_TRUNCATE_COMPLETE],
         [LB_CHECK_SYMBOL_EXPORT([truncate_complete_page],
                                 [mm/truncate.c],
                                 [AC_DEFINE(HAVE_TRUNCATE_COMPLETE_PAGE, 1,
                                            [kernel export truncate_complete_page])])
          LB_CHECK_SYMBOL_EXPORT([remove_from_page_cache],
                                 [mm/filemap.c],
                                 [AC_DEFINE(HAVE_REMOVE_FROM_PAGE_CACHE, 1,
                                            [kernel export remove_from_page_cache])])
          LB_CHECK_SYMBOL_EXPORT([delete_from_page_cache],
                                 [mm/filemap.c],
                                 [AC_DEFINE(HAVE_DELETE_FROM_PAGE_CACHE, 1,
                                            [kernel export delete_from_page_cache])])
         ])

AC_DEFUN([LC_EXPORT_D_REHASH_COND],
[LB_CHECK_SYMBOL_EXPORT([d_rehash_cond],
[fs/dcache.c],[
AC_DEFINE(HAVE_D_REHASH_COND, 1,
            [d_rehash_cond is exported by the kernel])
],[
])
])

AC_DEFUN([LC_EXPORT___D_REHASH],
[LB_CHECK_SYMBOL_EXPORT([__d_rehash],
[fs/dcache.c],[
AC_DEFINE(HAVE___D_REHASH, 1,
            [__d_rehash is exported by the kernel])
],[
])
])

# The actual symbol exported varies among architectures, so we need
# to check many symbols (but only in the current architecture.)  No
# matter what symbol is exported, the kernel #defines node_to_cpumask
# to the appropriate function and that's what we use.
AC_DEFUN([LC_EXPORT_NODE_TO_CPUMASK],
         [LB_CHECK_SYMBOL_EXPORT([node_to_cpumask],
                                 [arch/$LINUX_ARCH/mm/numa.c],
                                 [AC_DEFINE(HAVE_NODE_TO_CPUMASK, 1,
                                            [node_to_cpumask is exported by
                                             the kernel])]) # x86_64
          LB_CHECK_SYMBOL_EXPORT([node_to_cpu_mask],
                                 [arch/$LINUX_ARCH/kernel/smpboot.c],
                                 [AC_DEFINE(HAVE_NODE_TO_CPUMASK, 1,
                                            [node_to_cpumask is exported by
                                             the kernel])]) # ia64
          LB_CHECK_SYMBOL_EXPORT([node_2_cpu_mask],
                                 [arch/$LINUX_ARCH/kernel/smpboot.c],
                                 [AC_DEFINE(HAVE_NODE_TO_CPUMASK, 1,
                                            [node_to_cpumask is exported by
                                             the kernel])]) # i386
          ])

#
#
# between 2.6.5 - 2.6.22 filemap_populate is exported in some kernels
#
AC_DEFUN([LC_FILEMAP_POPULATE],
[AC_MSG_CHECKING([for exported filemap_populate])
LB_LINUX_TRY_COMPILE([
        #include <asm/page.h>
        #include <linux/mm.h>
],[
       filemap_populate(NULL, 0, 0, __pgprot(0), 0, 0);
],[
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_FILEMAP_POPULATE, 1, [Kernel exports filemap_populate])
],[
        AC_MSG_RESULT([no])
])
])

#
# added in 2.6.17
#
AC_DEFUN([LC_BIT_SPINLOCK_H],
[LB_CHECK_FILE([$LINUX/include/linux/bit_spinlock.h],[
	AC_MSG_CHECKING([if bit_spinlock.h can be compiled])
	LB_LINUX_TRY_COMPILE([
		#include <asm/processor.h>
		#include <linux/spinlock.h>
		#include <linux/bit_spinlock.h>
	],[],[
		AC_MSG_RESULT([yes])
		AC_DEFINE(HAVE_BIT_SPINLOCK_H, 1, [Kernel has bit_spinlock.h])
	],[
		AC_MSG_RESULT([no])
	])
],
[])
])

#
# LC_CONST_ACL_SIZE
#
AC_DEFUN([LC_CONST_ACL_SIZE],
[AC_MSG_CHECKING([calc acl size])
tmp_flags="$CFLAGS"
CFLAGS="$CFLAGS -I$LINUX/include -I$LINUX_OBJ/include -I$LINUX_OBJ/include2 -I$LINUX/arch/`echo $target_cpu|sed -e 's/powerpc64/powerpc/' -e 's/x86_64/x86/' -e 's/i.86/x86/'`/include -include $AUTOCONF_HDIR/autoconf.h $EXTRA_KCFLAGS"
AC_TRY_RUN([
        #define __KERNEL__
        #include <linux/types.h>
        #undef __KERNEL__
        // block include
        #define __LINUX_POSIX_ACL_H

        #ifdef CONFIG_FS_POSIX_ACL
        # include <linux/posix_acl_xattr.h>
        #endif

        #include <stdio.h>

        int main(void)
        {
                /* LUSTRE_POSIX_ACL_MAX_ENTRIES  = 32 */
            int size = posix_acl_xattr_size(32);
            FILE *f = fopen("acl.size","w+");
            fprintf(f,"%d", size);
            fclose(f);

            return 0;
        }
],[
	acl_size=`cat acl.size`
	AC_MSG_RESULT([ACL size $acl_size])
        AC_DEFINE_UNQUOTED(XATTR_ACL_SIZE, AS_TR_SH([$acl_size]), [size of xattr acl])
],[
        AC_ERROR([ACL size can't be computed])
],[
	AC_MSG_RESULT([can't check ACL size, make it 260])
        AC_DEFINE_UNQUOTED(XATTR_ACL_SIZE,260)
])
CFLAGS="$tmp_flags"
])

#
# LC_CAPA_CRYPTO
#
AC_DEFUN([LC_CAPA_CRYPTO],
[LB_LINUX_CONFIG_IM([CRYPTO],[],[
	AC_MSG_ERROR([Lustre capability require that CONFIG_CRYPTO is enabled in your kernel.])
])
LB_LINUX_CONFIG_IM([CRYPTO_HMAC],[],[
	AC_MSG_ERROR([Lustre capability require that CONFIG_CRYPTO_HMAC is enabled in your kernel.])
])
LB_LINUX_CONFIG_IM([CRYPTO_SHA1],[],[
	AC_MSG_ERROR([Lustre capability require that CONFIG_CRYPTO_SHA1 is enabled in your kernel.])
])
])

#
# LC_CONFIG_RMTCLIENT
#
dnl FIXME
dnl the AES symbol usually tied with arch, e.g. CRYPTO_AES_586
dnl FIXME
AC_DEFUN([LC_CONFIG_RMTCLIENT],
[LB_LINUX_CONFIG_IM([CRYPTO_AES],[],[
        AC_MSG_WARN([Lustre remote client require that CONFIG_CRYPTO_AES is enabled in your kernel.])
])
])

#
# LC_CONFIG_GSS_KEYRING (default enabled, if gss is enabled)
#
AC_DEFUN([LC_CONFIG_GSS_KEYRING],
[AC_MSG_CHECKING([whether to enable gss keyring backend])
 AC_ARG_ENABLE([gss_keyring],
               [AC_HELP_STRING([--disable-gss-keyring],
                               [disable gss keyring backend])],
               [],[enable_gss_keyring='yes'])
 AC_MSG_RESULT([$enable_gss_keyring])

 if test x$enable_gss_keyring != xno; then
        LB_LINUX_CONFIG_IM([KEYS],[],
                           [AC_MSG_ERROR([GSS keyring backend require that CONFIG_KEYS be enabled in your kernel.])])

        AC_CHECK_LIB([keyutils], [keyctl_search], [],
                     [AC_MSG_ERROR([libkeyutils is not found, which is required by gss keyring backend])],)

        AC_DEFINE([HAVE_GSS_KEYRING], [1],
                  [Define this if you enable gss keyring backend])
 fi
])

AC_DEFUN([LC_CONFIG_SUNRPC],
[LB_LINUX_CONFIG_IM([SUNRPC],[],
                    [AC_MSG_ERROR([kernel SUNRPC support is required by using GSS.])])
])

#
# LC_CONFIG_GSS (default disabled)
#
# Build gss and related tools of Lustre. Currently both kernel and user space
# parts are depend on linux platform.
#
AC_DEFUN([LC_CONFIG_GSS],
[AC_MSG_CHECKING([whether to enable gss/krb5 support])
 AC_ARG_ENABLE([gss],
               [AC_HELP_STRING([--enable-gss], [enable gss/krb5 support])],
               [],[enable_gss='no'])
 AC_MSG_RESULT([$enable_gss])

 if test x$enable_gss == xyes; then
        LC_CONFIG_GSS_KEYRING
        LC_CONFIG_SUNRPC

        AC_DEFINE([HAVE_GSS], [1], [Define this if you enable gss])

        LB_LINUX_CONFIG_IM([CRYPTO_MD5],[],
                           [AC_MSG_WARN([kernel MD5 support is recommended by using GSS.])])
        LB_LINUX_CONFIG_IM([CRYPTO_SHA1],[],
                           [AC_MSG_WARN([kernel SHA1 support is recommended by using GSS.])])
        LB_LINUX_CONFIG_IM([CRYPTO_SHA256],[],
                           [AC_MSG_WARN([kernel SHA256 support is recommended by using GSS.])])
        LB_LINUX_CONFIG_IM([CRYPTO_SHA512],[],
                           [AC_MSG_WARN([kernel SHA512 support is recommended by using GSS.])])

        AC_CHECK_LIB([gssapi], [gss_export_lucid_sec_context],
                     [GSSAPI_LIBS="$GSSAPI_LDFLAGS -lgssapi"],
                     [AC_CHECK_LIB([gssglue], [gss_export_lucid_sec_context],
                                   [GSSAPI_LIBS="$GSSAPI_LDFLAGS -lgssglue"],
                                   [AC_MSG_ERROR([libgssapi or libgssglue is not found, which is required by GSS.])])],)

        AC_SUBST(GSSAPI_LIBS)

        AC_KERBEROS_V5
 fi
])

AC_DEFUN([LC_TASK_CLENV_STORE],
[
        AC_MSG_CHECKING([if we can store cl_env in task_struct])
        if test x$have_task_clenv_store != xyes ; then
                LC_TASK_CLENV_TUX_INFO
        fi
])

# 2.6.12

# ~2.6.12 merge patch from oracle to convert tree_lock from spinlock to rwlock
# yet tree_lock is converted from rwlock to spin_lock since v2.6.26
AC_DEFUN([LC_RW_TREE_LOCK],
[AC_MSG_CHECKING([if kernel has tree_lock as rwlock])
tmp_flags="$EXTRA_KCFLAGS"
EXTRA_KCFLAGS="-Werror"
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
],[
	struct address_space a;

	write_lock(&a.tree_lock);
],[
        AC_MSG_RESULT([yes])
	AC_DEFINE(HAVE_RW_TREE_LOCK, 1, [kernel has tree_lock as rw_lock])
],[
        AC_MSG_RESULT([no])
])
EXTRA_KCFLAGS="$tmp_flags"
])

# 2.6.18

# LC_UMOUNTBEGIN_HAS_VFSMOUNT
# 2.6.18~2.6.25 umount_begin has different parameters
AC_DEFUN([LC_UMOUNTBEGIN_HAS_VFSMOUNT],
[AC_MSG_CHECKING([if umount_begin needs vfsmount parameter instead of super_block])
tmp_flags="$EXTRA_KCFLAGS"
EXTRA_KCFLAGS="-Werror"
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>

	struct vfsmount;
	static void cfg_umount_begin (struct vfsmount *v, int flags)
	{
    		;
	}

	static struct super_operations cfg_super_operations = {
		.umount_begin	= cfg_umount_begin,
	};
],[
	cfg_super_operations.umount_begin(NULL,0);
],[
	AC_MSG_RESULT(yes)
	AC_DEFINE(HAVE_UMOUNTBEGIN_VFSMOUNT, 1,
		[Define umount_begin need second argument])
],[
	AC_MSG_RESULT(no)
])
EXTRA_KCFLAGS="$tmp_flags"
])

#2.6.18 + RHEL5 (fc6)

#
# LC_LINUX_FIEMAP_H
#
# fiemap.h is added since v2.6.28
# RHEL5 2.6.18 has it, while SLES10 2.6.27 does not
#
AC_DEFUN([LC_LINUX_FIEMAP_H],
[LB_CHECK_FILE([$LINUX/include/linux/fiemap.h],[
        AC_MSG_CHECKING([if fiemap.h can be compiled])
        LB_LINUX_TRY_COMPILE([
                #include <linux/types.h>
                #include <linux/fiemap.h>
        ],[],[
                AC_MSG_RESULT([yes])
                AC_DEFINE(HAVE_LINUX_FIEMAP_H, 1, [Kernel has fiemap.h])
        ],[
                AC_MSG_RESULT([no])
        ])
],
[])
])

# 2.6.19

# LC_FILE_WRITEV
# 2.6.19 replaced writev with aio_write
AC_DEFUN([LC_FILE_WRITEV],
[AC_MSG_CHECKING([writev in fops])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
],[
        struct file_operations *fops = NULL;
        fops->writev = NULL;
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_FILE_WRITEV, 1,
                [use fops->writev])
],[
	AC_MSG_RESULT(no)
])
])

# LC_FILE_READV
# 2.6.19 replaced readv with aio_read
AC_DEFUN([LC_FILE_READV],
[AC_MSG_CHECKING([readv in fops])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
],[
        struct file_operations *fops = NULL;
        fops->readv = NULL;
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_FILE_READV, 1,
                [use fops->readv])
],[
        AC_MSG_RESULT(no)
])
])

# 2.6.20

# LC_CANCEL_DIRTY_PAGE
# 2.6.20 introduced cancel_dirty_page instead of clear_page_dirty.
AC_DEFUN([LC_CANCEL_DIRTY_PAGE],
        [AC_MSG_CHECKING([kernel has cancel_dirty_page])
        # the implementation of cancel_dirty_page in OFED 1.4.1's SLES10 SP2
        # backport is broken, so ignore it
        if test -f $OFED_BACKPORT_PATH/linux/mm.h &&
           test "$(sed -ne '/^static inline void cancel_dirty_page(struct page \*page, unsigned int account_size)$/,/^}$/p' $OFED_BACKPORT_PATH/linux/mm.h | md5sum)" = "c518cb32d6394760c5bca14cb7538d3e  -"; then
                AC_MSG_RESULT(no)
        else
                LB_LINUX_TRY_COMPILE([
                        #include <linux/mm.h>
                        #include <linux/page-flags.h>
],[
                        cancel_dirty_page(NULL, 0);
],[
                        AC_MSG_RESULT(yes)
                        AC_DEFINE(HAVE_CANCEL_DIRTY_PAGE, 1,
                                  [kernel has cancel_dirty_page instead of clear_page_dirty])
],[
                        AC_MSG_RESULT(no)
])
        fi
])

# raid5-zerocopy patch

#
# LC_PAGE_CONSTANT
#
# In order to support raid5 zerocopy patch, we have to patch the kernel to make
# it support constant page, which means the page won't be modified during the
# IO.
#
AC_DEFUN([LC_PAGE_CONSTANT],
[AC_MSG_CHECKING([if kernel have PageConstant defined])
LB_LINUX_TRY_COMPILE([
        #include <linux/mm.h>
        #include <linux/page-flags.h>
],[
        #ifndef PG_constant
        #error "Have no raid5 zcopy patch"
        #endif
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_PAGE_CONSTANT, 1, [kernel have PageConstant supported])
],[
        AC_MSG_RESULT(no);
])
])

# 2.6.22

# 2.6.22 lost second parameter for invalidate_bdev
AC_DEFUN([LC_INVALIDATE_BDEV_2ARG],
[AC_MSG_CHECKING([if invalidate_bdev has second argument])
LB_LINUX_TRY_COMPILE([
        #include <linux/buffer_head.h>
],[
        invalidate_bdev(NULL,0);
],[
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_INVALIDATE_BDEV_2ARG, 1,
                [invalidate_bdev has second argument])
],[
        AC_MSG_RESULT([no])
])
])

#
# check for crypto API
#
AC_DEFUN([LC_ASYNC_BLOCK_CIPHER],
[AC_MSG_CHECKING([if kernel has block cipher support])
LB_LINUX_TRY_COMPILE([
        #include <linux/err.h>
        #include <linux/crypto.h>
],[
        struct crypto_blkcipher *tfm;
        tfm = crypto_alloc_blkcipher("aes", 0, sizeof(tfm) );
],[
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_ASYNC_BLOCK_CIPHER, 1, [kernel has block cipher support])
],[
        AC_MSG_RESULT([no])
])
])

#
# check for struct hash_desc
#
AC_DEFUN([LC_STRUCT_HASH_DESC],
[AC_MSG_CHECKING([if kernel has struct hash_desc])
LB_LINUX_TRY_COMPILE([
        #include <linux/err.h>
        #include <linux/crypto.h>
],[
        struct hash_desc foo __attribute__ ((unused));
],[
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_STRUCT_HASH_DESC, 1, [kernel has struct hash_desc])
],[
        AC_MSG_RESULT([no])
])
])

#
# check for struct blkcipher_desc
#
AC_DEFUN([LC_STRUCT_BLKCIPHER_DESC],
[AC_MSG_CHECKING([if kernel has struct blkcipher_desc])
LB_LINUX_TRY_COMPILE([
        #include <linux/err.h>
        #include <linux/crypto.h>
],[
        struct blkcipher_desc foo __attribute__ ((unused));
],[
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_STRUCT_BLKCIPHER_DESC, 1, [kernel has struct blkcipher_desc])
],[
        AC_MSG_RESULT([no])
])
])

#
# 2.6.19 check for FS_RENAME_DOES_D_MOVE flag
#
AC_DEFUN([LC_FS_RENAME_DOES_D_MOVE],
[AC_MSG_CHECKING([if kernel has FS_RENAME_DOES_D_MOVE flag])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
],[
        int v __attribute__ ((unused));
        v = FS_RENAME_DOES_D_MOVE;
],[
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_FS_RENAME_DOES_D_MOVE, 1, [kernel has FS_RENAME_DOES_D_MOVE flag])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.23

# 2.6.23 have return type 'void' for unregister_blkdev
AC_DEFUN([LC_UNREGISTER_BLKDEV_RETURN_INT],
[AC_MSG_CHECKING([if unregister_blkdev return int])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
],[
        int i __attribute__ ((unused));
        i = unregister_blkdev(0,NULL);
],[
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_UNREGISTER_BLKDEV_RETURN_INT, 1,
                [unregister_blkdev return int])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.23 change .sendfile to .splice_read
AC_DEFUN([LC_KERNEL_SPLICE_READ],
[AC_MSG_CHECKING([if kernel has .splice_read])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
],[
        struct file_operations file;

        file.splice_read = NULL;
], [
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_KERNEL_SPLICE_READ, 1,
                [kernel has .slice_read])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.23 change .sendfile to .splice_read
# RHEL4 (-92 kernel) have both sendfile and .splice_read API
AC_DEFUN([LC_KERNEL_SENDFILE],
[AC_MSG_CHECKING([if kernel has .sendfile])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
],[
        struct file_operations file;

        file.sendfile = NULL;
], [
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_KERNEL_SENDFILE, 1,
                [kernel has .sendfile])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.23 extract nfs export related data into exportfs.h
AC_DEFUN([LC_HAVE_EXPORTFS_H],
[LB_CHECK_FILE([$LINUX/include/linux/exportfs.h], [
        AC_DEFINE(HAVE_LINUX_EXPORTFS_H, 1,
                [kernel has include/exportfs.h])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.23 has new page fault handling API
AC_DEFUN([LC_VM_OP_FAULT],
[AC_MSG_CHECKING([kernel has .fault in vm_operation_struct])
LB_LINUX_TRY_COMPILE([
        #include <linux/mm.h>
],[
        struct vm_operations_struct op;

        op.fault = NULL;
], [
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_VM_OP_FAULT, 1,
                [kernel has .fault in vm_operation_struct])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.23 add code to wait other users to complete before removing procfs entry
AC_DEFUN([LC_PROCFS_USERS],
[AC_MSG_CHECKING([if kernel has pde_users member in procfs entry struct])
LB_LINUX_TRY_COMPILE([
        #include <linux/proc_fs.h>
],[
        struct proc_dir_entry pde;

        pde.pde_users   = 0;
],[
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_PROCFS_USERS, 1,
                [kernel has pde_users member in procfs entry struct])
],[
	LB_LINUX_TRY_COMPILE([
		#include "$LINUX/fs/proc/internal.h"
	],[
		struct proc_dir_entry_aux pde_aux;

		pde_aux.pde_users = 0;
	],[
		AC_MSG_RESULT([yes])
		AC_DEFINE(HAVE_PROCFS_USERS, 1,
			[kernel has pde_users member in proc_dir_entry_aux])
	],[
		AC_MSG_RESULT([no])
	])
])
])

# 2.6.23 exports exportfs_decode_fh
AC_DEFUN([LC_EXPORTFS_DECODE_FH],
[LB_CHECK_SYMBOL_EXPORT([exportfs_decode_fh],
[fs/exportfs/expfs.c],[
        AC_DEFINE(HAVE_EXPORTFS_DECODE_FH, 1,
                [exportfs_decode_fh has been export])
],[
])
])

# 2.6.24

# 2.6.24 need linux/mm_types.h included
AC_DEFUN([LC_HAVE_MMTYPES_H],
[LB_CHECK_FILE([$LINUX/include/linux/mm_types.h], [
        AC_DEFINE(HAVE_LINUX_MMTYPES_H, 1,
                [kernel has include/mm_types.h])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.24 has bio_endio with 2 args
AC_DEFUN([LC_BIO_ENDIO_2ARG],
[AC_MSG_CHECKING([if kernel has bio_endio with 2 args])
LB_LINUX_TRY_COMPILE([
        #include <linux/bio.h>
],[
        bio_endio(NULL, 0);
], [
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_BIO_ENDIO_2ARG, 1,
                [kernel has bio_endio with 2 args])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.24 has new members in exports struct.
AC_DEFUN([LC_FH_TO_DENTRY],
[AC_MSG_CHECKING([if kernel has .fh_to_dentry member in export_operations struct])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
#ifdef HAVE_LINUX_EXPORTFS_H
        #include <linux/exportfs.h>
#endif
],[
        do{ }while(sizeof(((struct export_operations *)0)->fh_to_dentry));
], [
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_FH_TO_DENTRY, 1,
                [kernel has .fh_to_dentry member in export_operations struct])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.24 removes long aged procfs entry -> deleted member
AC_DEFUN([LC_PROCFS_DELETED],
[AC_MSG_CHECKING([if kernel has deleted member in procfs entry struct])
LB_LINUX_TRY_COMPILE([
	#include <linux/proc_fs.h>
],[
        struct proc_dir_entry pde;

        pde.deleted = sizeof(pde);
], [
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_PROCFS_DELETED, 1,
                [kernel has deleted member in procfs entry struct])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.24 has bdi_init()/bdi_destroy() functions.
AC_DEFUN([LC_EXPORT_BDI_INIT],
[LB_CHECK_SYMBOL_EXPORT([bdi_init],
[mm/backing-dev.c],[
        AC_DEFINE(HAVE_BDI_INIT, 1,
                [bdi_init/bdi_destroy functions are present])
],[
])
])

# 2.6.26

# 2.6.26 isn't export set_fs_pwd and change paramter in fs struct
AC_DEFUN([LC_FS_STRUCT_USE_PATH],
[AC_MSG_CHECKING([fs_struct use path structure])
LB_LINUX_TRY_COMPILE([
        #include <asm/atomic.h>
        #include <linux/spinlock.h>
        #include <linux/fs_struct.h>
],[
        struct fs_struct fs;

        fs.pwd = *((struct path *)sizeof(fs));
], [
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_FS_STRUCT_USE_PATH, 1,
                [fs_struct use path structure])
],[
        AC_MSG_RESULT([no])
])
])

#
# 2.6.27
#

# LC_SECURITY_PLUG  # for SLES10 SP2 (2.6.27)
# check security plug in sles10 sp2 kernel
AC_DEFUN([LC_SECURITY_PLUG],
[AC_MSG_CHECKING([If kernel has security plug support])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
        #include <linux/stddef.h>
],[
        notify_change(NULL, NULL, NULL);
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_SECURITY_PLUG, 1,
                [SLES10 SP2 use extra parameter in vfs])
],[
        AC_MSG_RESULT(no)
])
])

AC_DEFUN([LC_PGMKWRITE_USE_VMFAULT],
[AC_MSG_CHECKING([kernel .page_mkwrite uses struct vm_fault *])
tmp_flags="$EXTRA_KCFLAGS"
EXTRA_KCFLAGS="-Werror"
LB_LINUX_TRY_COMPILE([
        #include <linux/mm.h>
],[
        ((struct vm_operations_struct *)0)->page_mkwrite((struct vm_area_struct *)0, (struct vm_fault *)0);
], [
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_PGMKWRITE_USE_VMFAULT, 1,
                [kernel vm_operation_struct.page_mkwrite uses struct vm_fault * as second parameter])
],[
        AC_MSG_RESULT([no])
])
EXTRA_KCFLAGS="$tmp_flags"
])

AC_DEFUN([LC_PGMKWRITE_COMPACT],
[AC_MSG_CHECKING([if kernel .page_mkwrite is located in vm_operation_struct._pmkw])
tmp_flags="$EXTRA_KCFLAGS"
EXTRA_KCFLAGS="-Werror"
LB_LINUX_TRY_COMPILE([
	#include <linux/mm.h>
],[
	struct vm_operations_struct *vm_ops;

	vm_ops = NULL;
	vm_ops->_pmkw.page_mkwrite(NULL, NULL);
], [
	AC_MSG_RESULT([yes])
	AC_DEFINE(HAVE_PGMKWRITE_COMPACT, 1,
		[kernel .page_mkwrite is located in vm_operation_struct._pmkw])
],[
	AC_MSG_RESULT([no])
])
EXTRA_KCFLAGS="$tmp_flags"
])

AC_DEFUN([LC_INODE_PERMISION_2ARGS],
[AC_MSG_CHECKING([inode_operations->permission has two args])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
],[
        struct inode *inode __attribute__ ((unused));

        inode = NULL;
        inode->i_op->permission(NULL, 0);
],[
        AC_DEFINE(HAVE_INODE_PERMISION_2ARGS, 1,
                  [inode_operations->permission has two args])
        AC_MSG_RESULT([yes])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.27 have new page locking API
AC_DEFUN([LC_TRYLOCKPAGE],
[AC_MSG_CHECKING([kernel uses trylock_page for page lock])
LB_LINUX_TRY_COMPILE([
        #include <linux/pagemap.h>
],[
        trylock_page(NULL);
],[
        AC_DEFINE(HAVE_TRYLOCK_PAGE, 1,
                  [kernel uses trylock_page for page lock])
        AC_MSG_RESULT([yes])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.27 removed the read_inode from super_operations.
AC_DEFUN([LC_READ_INODE_IN_SBOPS],
[AC_MSG_CHECKING([super_operations has a read_inode field])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
],[
        struct super_operations *sop;
        sop->read_inode(NULL);
],[
        AC_DEFINE(HAVE_READ_INODE_IN_SBOPS, 1,
                [super_operations has a read_inode])
        AC_MSG_RESULT([yes])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.27 has inode_permission instead of permisson
AC_DEFUN([LC_EXPORT_INODE_PERMISSION],
[LB_CHECK_SYMBOL_EXPORT([inode_permission],
[fs/namei.c],[
AC_DEFINE(HAVE_EXPORT_INODE_PERMISSION, 1,
            [inode_permission is exported by the kernel])
],[
])
])

# 2.6.27 use 5th parameter in quota_on for remount.
AC_DEFUN([LC_QUOTA_ON_5ARGS],
[AC_MSG_CHECKING([quota_on needs 5 parameters])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
        #include <linux/quota.h>
],[
        struct quotactl_ops *qop = NULL;
        qop->quota_on(NULL, 0, 0, NULL, 0);
],[
        AC_DEFINE(HAVE_QUOTA_ON_5ARGS, 1,
                [quota_on needs 5 paramters])
        AC_MSG_RESULT([yes])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.27 use 3th parameter in quota_off for remount.
AC_DEFUN([LC_QUOTA_OFF_3ARGS],
[AC_MSG_CHECKING([quota_off needs 3 parameters])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
        #include <linux/quota.h>
],[
        struct quotactl_ops *qop = NULL;
        qop->quota_off(NULL, 0, 0);
],[
        AC_DEFINE(HAVE_QUOTA_OFF_3ARGS, 1,
                [quota_off needs 3 paramters])
        AC_MSG_RESULT([yes])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.27 has vfs_dq_off inline function.
AC_DEFUN([LC_VFS_DQ_OFF],
[AC_MSG_CHECKING([vfs_dq_off is defined])
LB_LINUX_TRY_COMPILE([
        #include <linux/quotaops.h>
],[
        vfs_dq_off(NULL, 0);
],[
        AC_DEFINE(HAVE_VFS_DQ_OFF, 1, [vfs_dq_off is defined])
        AC_MSG_RESULT([yes])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.34 has quotactl_ops->[sg]et_dqblk that take struct fs_disk_quota
AC_DEFUN([LC_HAVE_DQUOT_FS_DISK_QUOTA],
tmp_flags="$EXTRA_KCFLAGS"
EXTRA_KCFLAGS="-Werror"
[AC_MSG_CHECKING([if quotactl_ops.set_dqblk takes struct fs_disk_quota])
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
	#include <linux/quota.h>
],[
	struct quotactl_ops qops = {};
	struct fs_disk_quota fdq;
	qops.set_dqblk(NULL, 0, 0, &fdq);
],[
	AC_DEFINE(HAVE_DQUOT_FS_DISK_QUOTA, 1, [quotactl_ops.set_dqblk takes struct fs_disk_quota])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
EXTRA_KCFLAGS="$tmp_flags"
])

# 2.6.34 has renamed dquot options to dquot_*, check for dquot_suspend
AC_DEFUN([LC_HAVE_DQUOT_SUSPEND],
[AC_MSG_CHECKING([if dquot_suspend is defined])
LB_LINUX_TRY_COMPILE([
	#include <linux/quotaops.h>
],[
	dquot_suspend(NULL, -1);
],[
	AC_DEFINE(HAVE_DQUOT_SUSPEND, 1, [dquot_suspend is defined])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
])

# LC_LOCK_MAP_ACQUIRE
# after 2.6.27 lock_map_acquire replaces lock_acquire
AC_DEFUN([LC_LOCK_MAP_ACQUIRE],
[AC_MSG_CHECKING([if lock_map_acquire is defined])
LB_LINUX_TRY_COMPILE([
        #include <linux/lockdep.h>
],[
        lock_map_acquire(NULL);
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_LOCK_MAP_ACQUIRE, 1,
                [lock_map_acquire is defined])
],[
        AC_MSG_RESULT(no)
])
])

# 2.6.27.15-2 sles11

# 2.6.27 sles11 remove the bi_hw_segments
AC_DEFUN([LC_BI_HW_SEGMENTS],
[AC_MSG_CHECKING([struct bio has a bi_hw_segments field])
LB_LINUX_TRY_COMPILE([
        #include <linux/bio.h>
],[
        struct bio io;
        io.bi_hw_segments = sizeof(io);
],[
        AC_DEFINE(HAVE_BI_HW_SEGMENTS, 1,
                [struct bio has a bi_hw_segments field])
        AC_MSG_RESULT([yes])
],[
        AC_MSG_RESULT([no])
])
])

#
# 2.6.27 sles11 move the quotaio_v1{2}.h from include/linux to fs
# 2.6.32 move the quotaio_v1{2}.h from fs to fs/quota
AC_DEFUN([LC_HAVE_QUOTAIO_H],
[LB_CHECK_FILE([$LINUX/include/linux/quotaio_v2.h],[
        AC_DEFINE(HAVE_QUOTAIO_H, 1,
                [kernel has include/linux/quotaio_v2.h])
],[LB_CHECK_FILE([$LINUX/fs/quotaio_v2.h],[
               AC_DEFINE(HAVE_FS_QUOTAIO_H, 1,
                [kernel has fs/quotaio_v1.h])
],[LB_CHECK_FILE([$LINUX/fs/quota/quotaio_v2.h],[
               AC_DEFINE(HAVE_FS_QUOTA_QUOTAIO_H, 1,
                [kernel has fs/quota/quotaio_v2.h])
],[
        AC_MSG_RESULT([no])
])
])
])
])

# 2.6.27 sles11 has sb_any_quota_active
AC_DEFUN([LC_SB_ANY_QUOTA_ACTIVE],
[AC_MSG_CHECKING([Kernel has sb_any_quota_active])
LB_LINUX_TRY_COMPILE([
        #include <linux/quotaops.h>
],[
        sb_any_quota_active(NULL);
],[
        AC_DEFINE(HAVE_SB_ANY_QUOTA_ACTIVE, 1,
                [Kernel has a sb_any_quota_active])
        AC_MSG_RESULT([yes])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.27 sles11 has sb_has_quota_active
AC_DEFUN([LC_SB_HAS_QUOTA_ACTIVE],
[AC_MSG_CHECKING([Kernel has sb_has_quota_active])
LB_LINUX_TRY_COMPILE([
        #include <linux/quotaops.h>
],[
        sb_has_quota_active(NULL, 0);
],[
        AC_DEFINE(HAVE_SB_HAS_QUOTA_ACTIVE, 1,
                [Kernel has a sb_has_quota_active])
        AC_MSG_RESULT([yes])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.27 exported add_to_page_cache_lru.
AC_DEFUN([LC_EXPORT_ADD_TO_PAGE_CACHE_LRU],
[LB_CHECK_SYMBOL_EXPORT([add_to_page_cache_lru],
[mm/filemap.c],[
        AC_DEFINE(HAVE_ADD_TO_PAGE_CACHE_LRU, 1,
                [add_to_page_cache_lru functions are present])
],[
])
])

#
# 2.6.29 introduce sb_any_quota_loaded.
#
AC_DEFUN([LC_SB_ANY_QUOTA_LOADED],
[AC_MSG_CHECKING([Kernel has sb_any_quota_loaded])
LB_LINUX_TRY_COMPILE([
        #include <linux/quotaops.h>
],[
        sb_any_quota_loaded(NULL);
],[
        AC_DEFINE(HAVE_SB_ANY_QUOTA_LOADED, 1,
                [Kernel has a sb_any_quota_loaded])
        AC_MSG_RESULT([yes])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.30 x86 node_to_cpumask has been removed. must use cpumask_of_node
AC_DEFUN([LC_EXPORT_CPUMASK_OF_NODE],
         [LB_CHECK_SYMBOL_EXPORT([node_to_cpumask_map],
                                 [arch/$LINUX_ARCH/mm/numa.c],
                                 [AC_DEFINE(HAVE_CPUMASK_OF_NODE, 1,
                                            [node_to_cpumask_map is exported by
                                             the kernel])]) # x86_64
         ])


# 2.6.31 replaces blk_queue_hardsect_size by blk_queue_logical_block_size function
AC_DEFUN([LC_BLK_QUEUE_LOG_BLK_SIZE],
[AC_MSG_CHECKING([if blk_queue_logical_block_size is defined])
LB_LINUX_TRY_COMPILE([
        #include <linux/blkdev.h>
],[
        blk_queue_logical_block_size(NULL, 0);
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_BLK_QUEUE_LOG_BLK_SIZE, 1,
                  [blk_queue_logical_block_size is defined])
],[
        AC_MSG_RESULT(no)
])
])

# 2.6.32

# 2.6.32 introduced inode_newsize_ok
AC_DEFUN([LC_VFS_INODE_NEWSIZE_OK],
[AC_MSG_CHECKING([if inode_newsize_ok is defined])
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
],[
	return inode_newsize_ok(NULL, 0);
],[
	AC_MSG_RESULT(yes)
	AC_DEFINE(HAVE_VFS_INODE_NEWSIZE_OK, 1,
		  [inode_newsize_ok is defined])
],[
	AC_MSG_RESULT(no)
])
])

# 2.6.32 changes cache_detail's member cache_request to cache_upcall
# in kernel commit bc74b4f5e63a09fb78e245794a0de1e5a2716bbe
AC_DEFUN([LC_CACHE_UPCALL],
[AC_MSG_CHECKING([if cache_detail has cache_upcall field])
        LB_LINUX_TRY_COMPILE([
                #include <linux/sunrpc/cache.h>
        ],[
                struct cache_detail cd;
                cd.cache_upcall = NULL;
        ],[
                AC_MSG_RESULT(yes)
                AC_DEFINE(HAVE_CACHE_UPCALL, 1,
                          [cache_detail has cache_upcall field])
        ],[
                AC_MSG_RESULT(no)
        ])
])

# 2.6.32 add a limits member in struct request_queue.
AC_DEFUN([LC_REQUEST_QUEUE_LIMITS],
[AC_MSG_CHECKING([if request_queue has a limits field])
LB_LINUX_TRY_COMPILE([
        #include <linux/blkdev.h>
],[
        struct request_queue rq;
        rq.limits.io_min = 0;
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_REQUEST_QUEUE_LIMITS, 1,
                  [request_queue has a limits field])
],[
        AC_MSG_RESULT(no)
])
])

# 2.6.32 has bdi_register() functions.
AC_DEFUN([LC_EXPORT_BDI_REGISTER],
[LB_CHECK_SYMBOL_EXPORT([bdi_register],
[mm/backing-dev.c],[
        AC_DEFINE(HAVE_BDI_REGISTER, 1,
                [bdi_register function is present])
],[
])
])

# 2.6.32 add s_bdi for super block
AC_DEFUN([LC_SB_BDI],
[AC_MSG_CHECKING([if super_block has s_bdi field])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
],[
        struct super_block sb;
        sb.s_bdi = NULL;
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_SB_BDI, 1,
                  [super_block has s_bdi field])
],[
        AC_MSG_RESULT(no)
])
])

#  2.6.27.15-2 SuSE 11 sp0 kernels lack the name field for BDI
AC_DEFUN([LC_BDI_NAME],
[AC_MSG_CHECKING([if backing_device_info has name field])
LB_LINUX_TRY_COMPILE([
        #include <linux/blkdev.h>
],[
        struct backing_dev_info bdi;
        bdi.name = NULL;
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_BDI_NAME, 1,
                  [backing_device_info has name field])
],[
        AC_MSG_RESULT(no)
])
])

# 2.6.32 removes blk_queue_max_sectors and add blk_queue_max_hw_sectors
# check blk_queue_max_sectors and use it until disappear.
AC_DEFUN([LC_BLK_QUEUE_MAX_SECTORS],
[AC_MSG_CHECKING([if blk_queue_max_sectors is defined])
LB_LINUX_TRY_COMPILE([
        #include <linux/blkdev.h>
],[
        blk_queue_max_sectors(NULL, 0);
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_BLK_QUEUE_MAX_SECTORS, 1,
                  [blk_queue_max_sectors is defined])
],[
        AC_MSG_RESULT(no)
])
])

# 2.6.32 replaces 2 functions blk_queue_max_phys_segments and blk_queue_max_hw_segments by blk_queue_max_segments
AC_DEFUN([LC_BLK_QUEUE_MAX_SEGMENTS],
[AC_MSG_CHECKING([if blk_queue_max_segments is defined])
LB_LINUX_TRY_COMPILE([
        #include <linux/blkdev.h>
],[
        blk_queue_max_segments(NULL, 0);
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_BLK_QUEUE_MAX_SEGMENTS, 1,
                  [blk_queue_max_segments is defined])
],[
        AC_MSG_RESULT(no)
])
])

#
# LC_QUOTA64
#
# Check if kernel has been patched for 64-bit quota limits support.
# The upstream version of this patch in RHEL6 2.6.32 kernels introduces
# the constant QFMT_VFS_V1 in include/linux/quota.h, so we can check for
# that in the absence of quotaio_v1.h in the kernel headers.
#
AC_DEFUN([LC_QUOTA64],[
        AC_MSG_CHECKING([if kernel has 64-bit quota limits support])
tmp_flags="$EXTRA_KCFLAGS"
EXTRA_KCFLAGS="-I$LINUX/fs"
        LB_LINUX_TRY_COMPILE([
                #include <linux/kernel.h>
                #include <linux/fs.h>
                #ifdef HAVE_QUOTAIO_H
                # include <linux/quotaio_v2.h>
                int versions[] = V2_INITQVERSIONS_R1;
                struct v2_disk_dqblk_r1 dqblk_r1;
                #elif defined(HAVE_FS_QUOTA_QUOTAIO_H)
                # include <quota/quotaio_v2.h>
                struct v2r1_disk_dqblk dqblk_r1;
                #elif defined(HAVE_FS_QUOTAIO_H)
                # include <quotaio_v2.h>
                struct v2r1_disk_dqblk dqblk_r1;
                #else
                #include <linux/quota.h>
                int ver = QFMT_VFS_V1;
                #endif
        ],[],[
                AC_DEFINE(HAVE_QUOTA64, 1, [have quota64])
                AC_MSG_RESULT([yes])
        ],[
                LB_CHECK_FILE([$LINUX/include/linux/lustre_version.h],[
                        AC_MSG_ERROR([You have got no 64-bit kernel quota support.])
                ],[])
                AC_MSG_RESULT([no])
        ])
EXTRA_KCFLAGS=$tmp_flags
])

# 2.6.32 set_cpus_allowed is no more defined if CONFIG_CPUMASK_OFFSTACK=yes
AC_DEFUN([LC_SET_CPUS_ALLOWED],
         [AC_MSG_CHECKING([if kernel defines set_cpus_allowed])
          LB_LINUX_TRY_COMPILE(
                [#include <linux/sched.h>],
                [struct task_struct *p = NULL;
                 cpumask_t mask = { { 0 } };
                 (void) set_cpus_allowed(p, mask);],
                [AC_MSG_RESULT([yes])
                 AC_DEFINE(HAVE_SET_CPUS_ALLOWED, 1,
                           [set_cpus_allowed is exported by the kernel])],
                [AC_MSG_RESULT([no])] )])

# 2.6.32 introduces selinux_is_enabled()
AC_DEFUN([LC_SELINUX_IS_ENABLED],
[AC_MSG_CHECKING([if selinux_is_enabled is available])
LB_LINUX_TRY_COMPILE([
        #include <linux/selinux.h>
],[
        selinux_is_enabled();
],[
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_SELINUX_IS_ENABLED, 1,
                [selinux_is_enabled is defined])
],[
        AC_MSG_RESULT([no])
])
])

#
# LC_D_OBTAIN_ALIAS
# starting from 2.6.28 kernel replaces d_alloc_anon() with
# d_obtain_alias() for getting anonymous dentries
# RHEL5(2.6.18) has d_obtain_alias but SLES11SP0(2.6.27) not
#
AC_DEFUN([LC_D_OBTAIN_ALIAS],
[AC_MSG_CHECKING([d_obtain_alias exist in kernel])
LB_LINUX_TRY_COMPILE([
        #include <linux/dcache.h>
],[
        d_obtain_alias(NULL);
],[
        AC_DEFINE(HAVE_D_OBTAIN_ALIAS, 1,
                [d_obtain_alias exist in kernel])
        AC_MSG_RESULT([yes])
],[
        AC_MSG_RESULT([no])
])
])

#
# LC_EXPORT_GENERIC_ERROR_REMOVE_PAGE
#
AC_DEFUN([LC_EXPORT_GENERIC_ERROR_REMOVE_PAGE],
         [LB_CHECK_SYMBOL_EXPORT(
                        [generic_error_remove_page],
                        [mm/truncate.c],
                        [AC_DEFINE(HAS_GENERIC_ERROR_REMOVE_PAGE, 1,
                                [kernel export generic_error_remove_page])],
                        [])
         ]
)

# 2.6.32 if kernel export access_process_vm().
AC_DEFUN([LC_EXPORT_ACCESS_PROCESS_VM],
        [LB_CHECK_SYMBOL_EXPORT([access_process_vm],
                        [mm/memory.c],
                        [AC_DEFINE(HAVE_ACCESS_PROCESS_VM, 1,
                                [access_process_vm function is present])],
                        [])
        ]
)

#
# 2.6.36 fs_struct.lock use spinlock instead of rwlock.
#
AC_DEFUN([LC_FS_STRUCT_RWLOCK],
[AC_MSG_CHECKING([if fs_struct.lock use rwlock])
LB_LINUX_TRY_COMPILE([
        #include <asm/atomic.h>
        #include <linux/spinlock.h>
        #include <linux/fs_struct.h>
],[
        ((struct fs_struct *)0)->lock = (rwlock_t){ 0 };
],[
        AC_DEFINE(HAVE_FS_STRUCT_RWLOCK, 1,
                  [fs_struct.lock use rwlock])
        AC_MSG_RESULT([yes])
],[
        AC_MSG_RESULT([no])
])
])

#
# 2.6.36 super_operations add evict_inode method. it hybird of
# delete_inode & clear_inode.
#
AC_DEFUN([LC_SBOPS_EVICT_INODE],
[AC_MSG_CHECKING([if super_operations.evict_inode exist])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
],[
        ((struct super_operations *)0)->evict_inode(NULL);
],[
        AC_DEFINE(HAVE_SBOPS_EVICT_INODE, 1,
                [super_operations.evict_inode() is exist in kernel])
        AC_MSG_RESULT([yes])
],[
        AC_MSG_RESULT([no])
])
])

#
# 2.6.35 file_operations.fsync taken 2 arguments.
# 3.0.0 file_operations.fsync takes 4 arguments.
#
AC_DEFUN([LC_FILE_FSYNC],
[AC_MSG_CHECKING([if file_operations.fsync takes 4 or 2 arguments])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
],[
        ((struct file_operations *)0)->fsync(NULL, 0, 0, 0);
],[
        AC_DEFINE(HAVE_FILE_FSYNC_4ARGS, 1,
                [file_operations.fsync takes 4 arguments])
        AC_MSG_RESULT([yes, 4 args])
],[
        LB_LINUX_TRY_COMPILE([
                #include <linux/fs.h>
        ],[
           ((struct file_operations *)0)->fsync(NULL, 0);
        ],[
                AC_DEFINE(HAVE_FILE_FSYNC_2ARGS, 1,
                        [file_operations.fsync takes 2 arguments])
                AC_MSG_RESULT([yes, 2 args])
        ],[
                AC_MSG_RESULT([no])
        ])
])
])

#
# 2.6.37 remove kernel_locked
#
AC_DEFUN([LC_KERNEL_LOCKED],
[AC_MSG_CHECKING([if kernel_locked is defined])
LB_LINUX_TRY_COMPILE([
        #include <linux/smp_lock.h>
],[
        kernel_locked();
],[
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_KERNEL_LOCKED, 1,
                [kernel_locked is defined])
],[
        AC_MSG_RESULT([no])
])
])

#
# 2.6.38 dentry_operations.d_compare() taken 7 arguments.
#
AC_DEFUN([LC_D_COMPARE_7ARGS],
[AC_MSG_CHECKING([if d_compare taken 7 arguments])
LB_LINUX_TRY_COMPILE([
	#include <linux/dcache.h>
],[
	((struct dentry_operations*)0)->d_compare(NULL,NULL,NULL,NULL,0,NULL,NULL);
],[
	AC_DEFINE(HAVE_D_COMPARE_7ARGS, 1,
		[d_compare need 7 arguments])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
])

#
# 2.6.38 dentry_operations.d_delete() defined 'const' for 1st parameter.
#
AC_DEFUN([LC_D_DELETE_CONST],
[AC_MSG_CHECKING([if d_delete has const declare on first parameter])
tmp_flags="$EXTRA_KCFLAGS"
EXTRA_KCFLAGS="-Werror"
LB_LINUX_TRY_COMPILE([
	#include <linux/dcache.h>
],[
	const struct dentry *d = NULL;
	((struct dentry_operations*)0)->d_delete(d);
],[
	AC_DEFINE(HAVE_D_DELETE_CONST, const,
		[d_delete first parameter declared const])
	AC_MSG_RESULT([yes])
],[
	AC_DEFINE(HAVE_D_DELETE_CONST, , [])
	AC_MSG_RESULT([no])
])
EXTRA_KCFLAGS="$tmp_flags"
])

#
# 2.6.38 dcache_lock removed. rcu-walk commited.
#
AC_DEFUN([LC_DCACHE_LOCK],
[AC_MSG_CHECKING([if dcache_lock is exist])
LB_LINUX_TRY_COMPILE([
	#include <linux/dcache.h>
],[
	spin_lock(&dcache_lock);
],[
	AC_DEFINE(HAVE_DCACHE_LOCK, 1,
		[dcache_lock is exist])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
])

#
# 2.6.38 export blkdev_get_by_dev
#
AC_DEFUN([LC_BLKDEV_GET_BY_DEV],
[LB_CHECK_SYMBOL_EXPORT([blkdev_get_by_dev],
[fs/block_dev.c],[
AC_DEFINE(HAVE_BLKDEV_GET_BY_DEV, 1,
            [blkdev_get_by_dev is exported by the kernel])
],[
])
])

#
# 2.6.38 use path as 4th parameter in quota_on.
#
AC_DEFUN([LC_QUOTA_ON_USE_PATH],
[AC_MSG_CHECKING([quota_on use path as parameter])
tmp_flags="$EXTRA_KCFLAGS"
EXTRA_KCFLAGS="-Werror"
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
        #include <linux/quota.h>
],[
        ((struct quotactl_ops *)0)->quota_on(NULL, 0, 0, ((struct path*)0));
],[
        AC_DEFINE(HAVE_QUOTA_ON_USE_PATH, 1,
                [quota_on use path as 4th paramter])
        AC_MSG_RESULT([yes])
],[
        AC_MSG_RESULT([no])
])
EXTRA_KCFLAGS="$tmp_flags"
])

#
# 2.6.38 export simple_setattr
#
AC_DEFUN([LC_EXPORT_SIMPLE_SETATTR],
[LB_CHECK_SYMBOL_EXPORT([simple_setattr],
[fs/libfs.c],[
AC_DEFINE(HAVE_SIMPLE_SETATTR, 1,
            [simple_setattr is exported by the kernel])
],[
])
])

#
# 2.6.39 remove unplug_fn from request_queue.
#
AC_DEFUN([LC_REQUEST_QUEUE_UNPLUG_FN],
[AC_MSG_CHECKING([if request_queue has unplug_fn field])
LB_LINUX_TRY_COMPILE([
        #include <linux/blkdev.h>
],[
        do{ }while(sizeof(((struct request_queue *)0)->unplug_fn));
],[
        AC_DEFINE(HAVE_REQUEST_QUEUE_UNPLUG_FN, 1,
                  [request_queue has unplug_fn field])
        AC_MSG_RESULT([yes])
],[
        AC_MSG_RESULT([no])
])
])

#
# 2.6.39 replace get_sb with mount in struct file_system_type
#
AC_DEFUN([LC_HAVE_FSTYPE_MOUNT],
[AC_MSG_CHECKING([if file_system_type has mount field])
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
],[
	struct file_system_type fst;
	void *i = (void *) fst.mount;
],[
	AC_DEFINE(HAVE_FSTYPE_MOUNT, 1,
		[struct file_system_type has mount field])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
])

#
# 3.0 dirty_inode() has a flag parameter
# see kernel commit aa38572954ade525817fe88c54faebf85e5a61c0
#
AC_DEFUN([LC_DIRTY_INODE_WITH_FLAG],
[AC_MSG_CHECKING([if dirty_inode super_operation takes flag])
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
],[
	struct inode *inode;
	inode->i_sb->s_op->dirty_inode(NULL, 0);
],[
	AC_DEFINE(HAVE_DIRTY_INODE_HAS_FLAG, 1,
		  [dirty_inode super_operation takes flag])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
])

#
# 2.6.38 generic_permission taken 4 parameters.
# in fact, it means rcu-walk aware permission bring.
#
# 3.1 generic_permission taken 2 parameters.
# see kernel commit 2830ba7f34ebb27c4e5b8b6ef408cd6d74860890
#
AC_DEFUN([LC_GENERIC_PERMISSION],
[AC_MSG_CHECKING([if generic_permission take 2 or 4 arguments])
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
],[
	generic_permission(NULL, 0);
],[
	AC_DEFINE(HAVE_GENERIC_PERMISSION_2ARGS, 1,
		  [generic_permission taken 2 arguments])
	AC_MSG_RESULT([yes, 2 args])
],[
	LB_LINUX_TRY_COMPILE([
		#include <linux/fs.h>
	],[
		generic_permission(NULL, 0, 0, NULL);
	],[
		AC_DEFINE(HAVE_GENERIC_PERMISSION_4ARGS, 1,
			  [generic_permission taken 4 arguments])
		AC_MSG_RESULT([yes, 4 args])
	],[
		AC_MSG_RESULT([no])
	])
])
])

#
# 3.1 renames lock-manager ops(lock_manager_operations) from fl_xxx to lm_xxx
# see kernel commit 8fb47a4fbf858a164e973b8ea8ef5e83e61f2e50
#
AC_DEFUN([LC_LM_XXX_LOCK_MANAGER_OPS],
[AC_MSG_CHECKING([if lock-manager ops renamed to lm_xxx])
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
],[
	struct lock_manager_operations lm_ops;
	lm_ops.lm_compare_owner = NULL;
],[
	AC_DEFINE(HAVE_LM_XXX_LOCK_MANAGER_OPS, 1,
		  [lock-manager ops renamed to lm_xxx])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
])

#
# 3.1 kills inode->i_alloc_sem, use i_dio_count and inode_dio_wait/
#     inode_dio_done instead.
# see kernel commit bd5fe6c5eb9c548d7f07fe8f89a150bb6705e8e3
#
AC_DEFUN([LC_INODE_DIO_WAIT],
[AC_MSG_CHECKING([if inode->i_alloc_sem is killed and use inode_dio_wait/done.])
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
],[
	inode_dio_wait((struct inode *)0);
	inode_dio_done((struct inode *)0);
],[
	AC_DEFINE(HAVE_INODE_DIO_WAIT, 1,
		  [inode->i_alloc_sem is killed and use inode_dio_wait/done])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
])

#
# 3.1 adds get_acl method to inode_operations to read ACL from disk.
# see kernel commit 4e34e719e457f2e031297175410fc0bd4016a085
#
AC_DEFUN([LC_IOP_GET_ACL],
[AC_MSG_CHECKING([inode_operations has .get_acl member function])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
],[
        struct inode_operations iop;
        iop.get_acl = NULL;
],[
        AC_DEFINE(HAVE_IOP_GET_ACL, 1,
                  [inode_operations has .get_acl member function])
        AC_MSG_RESULT([yes])
],[
        AC_MSG_RESULT([no])
])
])

#
# 3.1.1 has ext4_blocks_for_truncate
#
AC_DEFUN([LC_BLOCKS_FOR_TRUNCATE],
[AC_MSG_CHECKING([if kernel has ext4_blocks_for_truncate])
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
	#include "$LINUX/fs/ext4/ext4_jbd2.h"
	#include "$LINUX/fs/ext4/truncate.h"
],[
	ext4_blocks_for_truncate(NULL);
],[
	AC_MSG_RESULT([yes])
	AC_DEFINE(HAVE_BLOCKS_FOR_TRUNCATE, 1,
		  [kernel has ext4_blocks_for_truncate])
],[
	AC_MSG_RESULT([no])
])
])

#
# 3.1 introduced generic_file_llseek_size()
#
AC_DEFUN([LC_FILE_LLSEEK_SIZE],
	[LB_CHECK_SYMBOL_EXPORT([generic_file_llseek_size],
	[fs/read_write.c],
        [AC_DEFINE(HAVE_FILE_LLSEEK_SIZE, 1,
		   [generic_file_llseek_size is exported by the kernel])])
])

#
# 3.2 request_queue.make_request_fn defined as function returns with void
# see kernel commit 5a7bbad27a410350e64a2d7f5ec18fc73836c14f
#
AC_DEFUN([LC_HAVE_VOID_MAKE_REQUEST_FN],
[AC_MSG_CHECKING([if request_queue.make_request_fn returns void but not int])
LB_LINUX_TRY_COMPILE([
	#include <linux/blkdev.h>
],[
	int ret;
	make_request_fn		*mrf;
	ret = mrf(NULL, NULL);
],[
	AC_MSG_RESULT([no])
],[
	AC_DEFINE(HAVE_VOID_MAKE_REQUEST_FN, 1,
		  [request_queue.make_request_fn returns void but not int])
	AC_MSG_RESULT([yes])
])
])

#
# 3.2 protects inode->i_nlink from direct modification
# see kernel commit a78ef704a8dd430225955f0709b22d4a6ba21deb
# at the same time adds set_nlink(), so checks set_nlink() for it.
#
AC_DEFUN([LC_HAVE_PROTECT_I_NLINK],
[AC_MSG_CHECKING([if inode->i_nlink is protected from direct modification])
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
],[
	struct inode i;
	set_nlink(&i, 1);
],[
	AC_DEFINE(HAVE_PROTECT_I_NLINK, 1,
		  [inode->i_nlink is protected from direct modification])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
])

#
# 3.3 introduces migrate_mode.h and migratepage has 4 args
#
AC_DEFUN([LC_HAVE_MIGRATE_HEADER],
[LB_CHECK_FILE([$LINUX/include/linux/migrate.h],[
		AC_DEFINE(HAVE_MIGRATE_H, 1,
		[kernel has include/linux/migrate.h])
],[LB_CHECK_FILE([$LINUX/include/linux/migrate_mode.h],[
		AC_DEFINE(HAVE_MIGRATE_MODE_H, 1,
			[kernel has include/linux/migrate_mode.h])
],[
	AC_MSG_RESULT([no])
])
])
])

AC_DEFUN([LC_MIGRATEPAGE_4ARGS],
[AC_MSG_CHECKING([if address_space_operations.migratepage has 4 args])
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
#ifdef HAVE_MIGRATE_H
	#include <linux/migrate.h>
#elif defined(HAVE_MIGRATE_MODE_H)
	#include <linux/migrate_mode.h>
#endif
],[
	struct address_space_operations aops;

	aops.migratepage(NULL, NULL, NULL, MIGRATE_ASYNC);
],[
	AC_DEFINE(HAVE_MIGRATEPAGE_4ARGS, 1,
		[address_space_operations.migratepage has 4 args])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
])

#
# 3.3 switchs super_operations to use dentry as parameter (but not vfsmount)
# see kernel commit 34c80b1d93e6e20ca9dea0baf583a5b5510d92d4
#
AC_DEFUN([LC_SUPEROPS_USE_DENTRY],
[AC_MSG_CHECKING([if super_operations use dentry as parameter])
tmp_flags="$EXTRA_KCFLAGS"
EXTRA_KCFLAGS="-Werror"
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
	int show_options(struct seq_file *seq, struct dentry *root){
		return 0;
	}
],[
	struct super_operations ops;
	ops.show_options = show_options;
],[
	AC_DEFINE(HAVE_SUPEROPS_USE_DENTRY, 1,
		  [super_operations use dentry as parameter])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
EXTRA_KCFLAGS="$tmp_flags"
])

#
# 3.3 switchs inode_operations to use umode_t as parameter (but not int)
# see kernel commit 1a67aafb5f72a436ca044293309fa7e6351d6a35
#
AC_DEFUN([LC_INODEOPS_USE_UMODE_T],
[AC_MSG_CHECKING([if inode_operations use umode_t as parameter])
tmp_flags="$EXTRA_KCFLAGS"
EXTRA_KCFLAGS="-Werror"
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
	#include <linux/types.h>
	int my_mknod(struct inode *dir, struct dentry *dchild,
		     umode_t mode, dev_t dev)
	{
		return 0;
	}
],[
	struct inode_operations ops;
	ops.mknod = my_mknod;
],[
	AC_DEFINE(HAVE_INODEOPS_USE_UMODE_T, 1,
		  [inode_operations use umode_t as parameter])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
EXTRA_KCFLAGS="$tmp_flags"
])

# 3.4 kmap_atomic removes second argument
# see kernel commit 1ec9c5ddc17aa398f05646abfcbaf315b544e62f
#
AC_DEFUN([LC_KMAP_ATOMIC_HAS_1ARG],
[AC_MSG_CHECKING([if kmap_atomic has only 1 argument])
LB_LINUX_TRY_COMPILE([
	#include <linux/highmem.h>
],[
	kmap_atomic(NULL);
],[
	AC_DEFINE(HAVE_KMAP_ATOMIC_HAS_1ARG, 1,
		  [have kmap_atomic has only 1 argument])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
])

#
# 3.4 switchs touch_atime to struct path
# see kernel commit 68ac1234fb949b66941d94dce4157742799fc581
#
AC_DEFUN([LC_TOUCH_ATIME_1ARG],
[AC_MSG_CHECKING([if touch_atime use one argument])
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
],[
	touch_atime((struct path *)NULL);
],[
	AC_DEFINE(HAVE_TOUCH_ATIME_1ARG, 1,
		  [touch_atime use one argument])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
])

#
# 3.4 converts d_alloc_root to d_make_root
# see kernel commit 32991ab305ace7017c62f8eecbe5eb36dc32e13b
#
AC_DEFUN([LC_HAVE_D_MAKE_ROOT],
[AC_MSG_CHECKING([if have d_make_root])
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
],[
	d_make_root((struct inode *)NULL);
],[
	AC_DEFINE(HAVE_D_MAKE_ROOT, 1,
		  [have d_make_root])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
])

#
# 3.5 renames end_writeback() back to clear_inode()...
# see kernel commit dbd5768f87ff6fb0a4fe09c4d7b6c4a24de99430
#
AC_DEFUN([LC_HAVE_CLEAR_INODE],
[AC_MSG_CHECKING([if have clear_inode])
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
],[
	clear_inode((struct inode *)NULL);
],[
	AC_DEFINE(HAVE_CLEAR_INODE, 1,
		  [have clear_inode])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
])

#
# 3.5 encode_fh has parent inode passed in directly
# see kernel commit b0b0382b
#
AC_DEFUN([LC_HAVE_ENCODE_FH_PARENT],
[AC_MSG_CHECKING([if encode_fh have parent inode as parameter])
tmp_flags="$EXTRA_KCFLAGS"
EXTRA_KCFLAGS="-Werror"
LB_LINUX_TRY_COMPILE([
	#include <linux/exportfs.h>
	#include <linux/fs.h>
	#include <linux/types.h>
	int ll_encode_fh(struct inode *i, __u32 *a, int *b, struct inode *p)
	{
		return 0;
	}
],[
	struct export_operations exp_op;
	exp_op.encode_fh = ll_encode_fh;
],[
	AC_DEFINE(HAVE_ENCODE_FH_PARENT, 1,
		  [have parent inode as parameter])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
EXTRA_KCFLAGS="$tmp_flags"
])

# 3.5 has generic_file_llseek_size with 5 args
AC_DEFUN([LC_FILE_LLSEEK_SIZE_5ARG],
[AC_MSG_CHECKING([if kernel has generic_file_llseek_size with 5 args])
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
],[
	generic_file_llseek_size(NULL, 0, 0, 0, 0);
], [
	AC_MSG_RESULT([yes])
	AC_DEFINE(HAVE_FILE_LLSEEK_SIZE_5ARGS, 1,
		[kernel has generic_file_llseek_size with 5 args])
],[
	AC_MSG_RESULT([no])
])
])

#
# 3.6 switch i_dentry/d_alias from list to hlist
#
AC_DEFUN([LC_HAVE_DENTRY_D_ALIAS_HLIST],
[AC_MSG_CHECKING([if i_dentry/d_alias uses hlist])
tmp_flags="$EXTRA_KCFLAGS"
EXTRA_KCFLAGS="-Werror"
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
	#include <linux/list.h>
],[
	struct inode inode;
	struct dentry dentry;
	struct hlist_head head;
	struct hlist_node node;
	inode.i_dentry = head;
	dentry.d_alias = node;
],[
	AC_DEFINE(HAVE_DENTRY_D_ALIAS_HLIST, 1,
		  [have i_dentry/d_alias uses hlist])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
EXTRA_KCFLAGS="$tmp_flags"
])

#
# 3.6 dentry_open uses struct path as first argument
# see kernel commit 765927b2
#
AC_DEFUN([LC_DENTRY_OPEN_USE_PATH],
[AC_MSG_CHECKING([if dentry_open uses struct path as first argument])
tmp_flags="$EXTRA_KCFLAGS"
EXTRA_KCFLAGS="-Werror"
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
	#include <linux/path.h>
],[
	struct path path;
	dentry_open(&path, 0, NULL);
],[
	AC_DEFINE(HAVE_DENTRY_OPEN_USE_PATH, 1,
		  [dentry_open uses struct path as first argument])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
EXTRA_KCFLAGS="$tmp_flags"
])

#
# 3.6 vfs adds iop->atomic_open
#
AC_DEFUN([LC_HAVE_IOP_ATOMIC_OPEN],
[AC_MSG_CHECKING([if iop has atomic_open])
LB_LINUX_TRY_COMPILE([
	#include <linux/fs.h>
],[
	struct inode_operations iop;
	iop.atomic_open = NULL;
],[
	AC_DEFINE(HAVE_IOP_ATOMIC_OPEN, 1,
		  [have iop atomic_open])
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
])
])

#
# LC_PROG_LINUX
#
# Lustre linux kernel checks
#
AC_DEFUN([LC_PROG_LINUX],
         [
         LC_CONFIG_PINGER
         LC_CONFIG_CHECKSUM
         LC_CONFIG_LIBLUSTRE_RECOVERY
         LC_CONFIG_HEALTH_CHECK_WRITE
         LC_CONFIG_LRU_RESIZE
         LC_LLITE_LLOOP_MODULE

         # RHEL4 patches
         LC_EXPORT_TRUNCATE_COMPLETE
         LC_EXPORT_D_REHASH_COND
         LC_EXPORT___D_REHASH
         LC_EXPORT_NODE_TO_CPUMASK

         LC_FILEMAP_POPULATE
         LC_BIT_SPINLOCK_H

         LC_CONST_ACL_SIZE

         LC_CAPA_CRYPTO
         LC_CONFIG_RMTCLIENT
         LC_CONFIG_GSS
         LC_TASK_CLENV_STORE

         # 2.6.12
         LC_RW_TREE_LOCK

         # 2.6.18
         LC_UMOUNTBEGIN_HAS_VFSMOUNT

         #2.6.18 + RHEL5 (fc6)
         LC_LINUX_FIEMAP_H

         # 2.6.19
         LC_FILE_WRITEV
         LC_FILE_READV

         # 2.6.20
         LC_CANCEL_DIRTY_PAGE

         # raid5-zerocopy patch
         LC_PAGE_CONSTANT

	 # 2.6.22
         LC_INVALIDATE_BDEV_2ARG
         LC_ASYNC_BLOCK_CIPHER
         LC_STRUCT_HASH_DESC
         LC_STRUCT_BLKCIPHER_DESC
         LC_FS_RENAME_DOES_D_MOVE

         # 2.6.23
         LC_UNREGISTER_BLKDEV_RETURN_INT
         LC_KERNEL_SPLICE_READ
         LC_KERNEL_SENDFILE
         LC_HAVE_EXPORTFS_H
         LC_VM_OP_FAULT
         LC_PROCFS_USERS
         LC_EXPORTFS_DECODE_FH

         # 2.6.24
         LC_HAVE_MMTYPES_H
         LC_BIO_ENDIO_2ARG
         LC_FH_TO_DENTRY
         LC_PROCFS_DELETED
         LC_EXPORT_BDI_INIT

         # 2.6.26
         LC_FS_STRUCT_USE_PATH

         # 2.6.27
         LC_SECURITY_PLUG  # for SLES10 SP2
         LC_PGMKWRITE_USE_VMFAULT
	 LC_PGMKWRITE_COMPACT
         LC_INODE_PERMISION_2ARGS
         LC_TRYLOCKPAGE
         LC_READ_INODE_IN_SBOPS
         LC_EXPORT_INODE_PERMISSION
         LC_QUOTA_ON_5ARGS
         LC_QUOTA_OFF_3ARGS
         LC_VFS_DQ_OFF
         LC_LOCK_MAP_ACQUIRE

         # 2.6.27.15-2 sles11
         LC_BI_HW_SEGMENTS
         LC_HAVE_QUOTAIO_H
         LC_BDI_NAME
         LC_SB_ANY_QUOTA_ACTIVE
         LC_SB_HAS_QUOTA_ACTIVE
         LC_EXPORT_ADD_TO_PAGE_CACHE_LRU

         # 2.6.29
         LC_SB_ANY_QUOTA_LOADED

	 # 2.6.30
	 LC_EXPORT_CPUMASK_OF_NODE

         # 2.6.31
         LC_BLK_QUEUE_LOG_BLK_SIZE

         # 2.6.32
         LC_REQUEST_QUEUE_LIMITS
         LC_EXPORT_BDI_REGISTER
         LC_SB_BDI
         LC_BLK_QUEUE_MAX_SECTORS
         LC_BLK_QUEUE_MAX_SEGMENTS
         LC_SET_CPUS_ALLOWED
         LC_CACHE_UPCALL
         LC_EXPORT_GENERIC_ERROR_REMOVE_PAGE
         LC_SELINUX_IS_ENABLED
         LC_EXPORT_ACCESS_PROCESS_VM
	 LC_VFS_INODE_NEWSIZE_OK

	 # 2.6.34
	 LC_HAVE_DQUOT_FS_DISK_QUOTA
	 LC_HAVE_DQUOT_SUSPEND

         # 2.6.35, 3.0.0
         LC_FILE_FSYNC
         LC_EXPORT_SIMPLE_SETATTR

         # 2.6.36
         LC_FS_STRUCT_RWLOCK
         LC_SBOPS_EVICT_INODE

         # 2.6.37
         LC_KERNEL_LOCKED

         # 2.6.38
         LC_BLKDEV_GET_BY_DEV
         LC_GENERIC_PERMISSION
         LC_QUOTA_ON_USE_PATH
         LC_DCACHE_LOCK
         LC_D_COMPARE_7ARGS
         LC_D_DELETE_CONST

         # 2.6.39
         LC_REQUEST_QUEUE_UNPLUG_FN
	 LC_HAVE_FSTYPE_MOUNT

	 # 3.0
	 LC_DIRTY_INODE_WITH_FLAG

	 # 3.1
	 LC_LM_XXX_LOCK_MANAGER_OPS
	 LC_INODE_DIO_WAIT
	 LC_IOP_GET_ACL
	 LC_FILE_LLSEEK_SIZE

	 # 3.1.1
	 LC_BLOCKS_FOR_TRUNCATE

	 # 3.2
	 LC_HAVE_VOID_MAKE_REQUEST_FN
	 LC_HAVE_PROTECT_I_NLINK

	 # 3.3
	 LC_HAVE_MIGRATE_HEADER
	 LC_MIGRATEPAGE_4ARGS
	 LC_SUPEROPS_USE_DENTRY
	 LC_INODEOPS_USE_UMODE_T

	 # 3.4
	 LC_TOUCH_ATIME_1ARG
	 LC_HAVE_D_MAKE_ROOT
	 LC_KMAP_ATOMIC_HAS_1ARG

	 # 3.5
	 LC_HAVE_CLEAR_INODE
	 LC_HAVE_ENCODE_FH_PARENT
	 LC_FILE_LLSEEK_SIZE_5ARG

	 # 3.6
	 LC_HAVE_DENTRY_D_ALIAS_HLIST
	 LC_DENTRY_OPEN_USE_PATH
	 LC_HAVE_IOP_ATOMIC_OPEN

	 #
	 if test x$enable_server = xyes ; then
		AC_DEFINE(HAVE_SERVER_SUPPORT, 1, [support server])
		LC_FUNC_DEV_SET_RDONLY
		LC_STACK_SIZE
		LC_QUOTA64
		LC_QUOTA_CONFIG
	 fi
])

#
# LC_CONFIG_CLIENT_SERVER
#
# Build client/server sides of Lustre
#
AC_DEFUN([LC_CONFIG_CLIENT_SERVER],
[AC_MSG_CHECKING([whether to build Lustre server support])
AC_ARG_ENABLE([server],
	AC_HELP_STRING([--disable-server],
			[disable Lustre server support]),
	[],[enable_server='yes'])
AC_MSG_RESULT([$enable_server])

AC_MSG_CHECKING([whether to build Lustre client support])
AC_ARG_ENABLE([client],
	AC_HELP_STRING([--disable-client],
			[disable Lustre client support]),
	[],[enable_client='yes'])
AC_MSG_RESULT([$enable_client])])

#
# LC_CONFIG_LIBLUSTRE
#
# whether to build liblustre
#
AC_DEFUN([LC_CONFIG_LIBLUSTRE],
[AC_MSG_CHECKING([whether to build Lustre library])
AC_ARG_ENABLE([liblustre],
	AC_HELP_STRING([--disable-liblustre],
			[disable building of Lustre library]),
	[],[enable_liblustre=$with_sysio])
AC_MSG_RESULT([$enable_liblustre])
# only build sysio if liblustre is built
with_sysio="$enable_liblustre"

AC_MSG_CHECKING([whether to build liblustre tests])
AC_ARG_ENABLE([liblustre-tests],
	AC_HELP_STRING([--enable-liblustre-tests],
			[enable liblustre tests, if --disable-tests is used]),
	[],[enable_liblustre_tests=$enable_tests])
if test x$enable_liblustre != xyes ; then
   enable_liblustre_tests='no'
fi
AC_MSG_RESULT([$enable_liblustre_tests])

AC_MSG_CHECKING([whether to enable liblustre acl])
AC_ARG_ENABLE([liblustre-acl],
	AC_HELP_STRING([--disable-liblustre-acl],
			[disable ACL support for liblustre]),
	[],[enable_liblustre_acl=yes])
AC_MSG_RESULT([$enable_liblustre_acl])
if test x$enable_liblustre_acl = xyes ; then
  AC_DEFINE(LIBLUSTRE_POSIX_ACL, 1, Liblustre Support ACL-enabled MDS)
fi

# 2.6.29 change prepare/commit_write to write_begin/end
AC_DEFUN([LC_WRITE_BEGIN_END],
[AC_MSG_CHECKING([if kernel has .write_begin/end])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
        #include <linux/pagemap.h>
#ifdef HAVE_LINUX_MMTYPES_H
        #include <linux/mm_types.h>
#endif
],[
        struct address_space_operations aops;
        struct page *page;

        aops.write_begin = NULL;
        aops.write_end = NULL;
        page = grab_cache_page_write_begin(NULL, 0, 0);
], [
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_KERNEL_WRITE_BEGIN_END, 1,
                [kernel has .write_begin/end])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.29 blkdev_put has 2 arguments
AC_DEFUN([LC_BLKDEV_PUT_2ARGS],
[AC_MSG_CHECKING([blkdev_put needs 2 parameters])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
],[
        blkdev_put(NULL, 0);
],[
        AC_DEFINE(HAVE_BLKDEV_PUT_2ARGS, 1,
                [blkdev_put needs 2 paramters])
        AC_MSG_RESULT([yes])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.29 dentry_open has 4 arguments
AC_DEFUN([LC_DENTRY_OPEN_4ARGS],
[AC_MSG_CHECKING([dentry_open needs 4 parameters])
LB_LINUX_TRY_COMPILE([
        #include <linux/fs.h>
],[
        dentry_open(NULL, NULL, 0, NULL);
],[
        AC_DEFINE(HAVE_DENTRY_OPEN_4ARGS, 1,
                [dentry_open needs 4 paramters])
        AC_MSG_RESULT([yes])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.29 split file and anonymous page queues
AC_DEFUN([LC_PAGEVEC_LRU_ADD_FILE],
[AC_MSG_CHECKING([if kernel has .pagevec_lru_add_file])
LB_LINUX_TRY_COMPILE([
        #include <linux/mm.h>
        #include <linux/pagevec.h>
],[
        struct pagevec lru_pagevec;

        pagevec_init(&lru_pagevec, 0);
        pagevec_lru_add_file(&lru_pagevec);
],[
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_PAGEVEC_LRU_ADD_FILE, 1,
                [kernel has .pagevec_lru_add_file])
],[
        AC_MSG_RESULT([no])
])
])

#
# --enable-mpitest
#
AC_ARG_ENABLE(mpitests,
	AC_HELP_STRING([--enable-mpitests=yes|no|mpicc wrapper],
                           [include mpi tests]),
	[
	 enable_mpitests=yes
         case $enableval in
         yes)
		MPICC_WRAPPER=mpicc
		;;
         no)
		enable_mpitests=no
		;;
         *)
		MPICC_WRAPPER=$enableval
                 ;;
	 esac
	],
	[
	MPICC_WRAPPER=mpicc
	enable_mpitests=yes
	]
)

if test x$enable_mpitests != xno; then
	AC_MSG_CHECKING([whether mpitests can be built])
	oldcc=$CC
	CC=$MPICC_WRAPPER
	AC_LINK_IFELSE(
	    [AC_LANG_PROGRAM([[
		    #include <mpi.h>
	        ]],[[
		    int flag;
		    MPI_Initialized(&flag);
		]])],
	    [
		    AC_MSG_RESULT([yes])
	    ],[
		    AC_MSG_RESULT([no])
		    enable_mpitests=no
	])
	CC=$oldcc
fi
AC_SUBST(MPICC_WRAPPER)

AC_MSG_NOTICE([Enabling Lustre configure options for libsysio])
ac_configure_args="$ac_configure_args --with-lustre-hack --with-sockets"

LC_CONFIG_PINGER
LC_CONFIG_LIBLUSTRE_RECOVERY
])

#
# LC_CONFIG_QUOTA
#
# whether to enable quota support global control
#
AC_DEFUN([LC_CONFIG_QUOTA],
[AC_ARG_ENABLE([quota],
	AC_HELP_STRING([--enable-quota],
			[enable quota support]),
	[],[enable_quota='yes'])
])

AC_DEFUN([LC_QUOTA],
[#check global
LC_CONFIG_QUOTA
#check for utils
AC_CHECK_HEADER(sys/quota.h,
                [AC_DEFINE(HAVE_SYS_QUOTA_H, 1, [Define to 1 if you have <sys/quota.h>.])],
                [AC_MSG_ERROR([don't find <sys/quota.h> in your system])])
])

#
# LC_CONFIG_SPLIT
#
# whether to enable split support
#
AC_DEFUN([LC_CONFIG_SPLIT],
[AC_MSG_CHECKING([whether to enable split support])
AC_ARG_ENABLE([split],
	AC_HELP_STRING([--enable-split],
			[enable split support]),
	[],[enable_split='no'])
AC_MSG_RESULT([$enable_split])
if test x$enable_split != xno; then
   AC_DEFINE(HAVE_SPLIT_SUPPORT, 1, [enable split support])
fi
])

# RHEL5(2.6.18) has tux_info
AC_DEFUN([LC_TASK_CLENV_TUX_INFO],
[AC_MSG_CHECKING([tux_info])
LB_LINUX_TRY_COMPILE([
        #include <linux/sched.h>
],[
        struct task_struct task;
        &task.tux_info;
],[
        AC_MSG_RESULT([yes])
        AC_DEFINE(LL_TASK_CL_ENV, tux_info, [have tux_info])
        have_task_clenv_store='yes'
],[
        AC_MSG_RESULT([no])
])
])

#
# LC_LLITE_LLOOP_MODULE
# lloop_llite.ko does not currently work with page sizes
# of 64k or larger.
#
AC_DEFUN([LC_LLITE_LLOOP_MODULE],
[AC_MSG_CHECKING([whether to enable llite_lloop module])
LB_LINUX_TRY_COMPILE([
        #include <asm/page.h>
],[
        #if PAGE_SIZE >= 65536
        #error "PAGE_SIZE >= 65536"
        #endif
],[
        enable_llite_lloop_module='yes'
        AC_MSG_RESULT([yes])
],[
        enable_llite_lloop_module='no'
        AC_MSG_RESULT([no])
])
])

#
# LC_OSD_ADDON
#
# configure support for optional OSD implementation
#
AC_DEFUN([LC_OSD_ADDON],
[AC_MSG_CHECKING([for osd])
AC_ARG_WITH([osd],
	AC_HELP_STRING([--with-osd=path],
                       [set path to optional osd]),
        [
		case $with_osd in
			no)     ENABLEOSDADDON=0
				;;
			*)	OSDADDON="${with_osd}"
				ENABLEOSDADDON=1
				;;
		esac
	], [
		ENABLEOSDADDON=0
	])
if test $ENABLEOSDADDON -eq 0; then
	AC_MSG_RESULT([no])
	OSDADDON=
else
	OSDMODNAME=`basename $OSDADDON`
	if test -e $LUSTRE/$OSDMODNAME; then
		AC_MSG_RESULT([can't link])
		OSDADDON=
	elif ln -s $OSDADDON $LUSTRE/$OSDMODNAME; then
		AC_MSG_RESULT([$OSDMODNAME])
		OSDADDON="subdir-m += $OSDMODNAME"
	else
		AC_MSG_RESULT([can't link])
		OSDADDON=
	fi
fi
AC_SUBST(OSDADDON)
])

#
# LC_CONFIGURE
#
# other configure checks
#
AC_DEFUN([LC_CONFIGURE],
[LC_CONFIG_OBD_BUFFER_SIZE

if test $target_cpu == "i686" -o $target_cpu == "x86_64"; then
        CFLAGS="$CFLAGS -Werror"
fi

# maximum MDS thread count
LC_MDS_MAX_THREADS

# include/liblustre.h
AC_CHECK_HEADERS([sys/user.h sys/vfs.h stdint.h blkid/blkid.h])

# liblustre/llite_lib.h
AC_CHECK_HEADERS([xtio.h file.h])

# liblustre/dir.c
AC_CHECK_HEADERS([linux/types.h sys/types.h linux/unistd.h unistd.h])

# liblustre/lutil.c
AC_CHECK_HEADERS([netinet/in.h arpa/inet.h catamount/data.h])
AC_CHECK_FUNCS([inet_ntoa])

# libsysio/src/readlink.c
LC_READLINK_SSIZE_T

# lvfs/prng.c - depends on linux/types.h from liblustre/dir.c
AC_CHECK_HEADERS([linux/random.h], [], [],
                 [#ifdef HAVE_LINUX_TYPES_H
                  # include <linux/types.h>
                  #endif
                 ])

# utils/llverfs.c
AC_CHECK_HEADERS([ext2fs/ext2fs.h])

# check for -lz support
ZLIB=""
AC_CHECK_LIB([z],
             [adler32],
             [AC_CHECK_HEADERS([zlib.h],
                               [ZLIB="-lz"
                                AC_DEFINE([HAVE_ADLER], 1,
                                          [support alder32 checksum type])],
                               [AC_MSG_WARN([No zlib-devel package found,
                                             unable to use adler32 checksum])])],
             [AC_MSG_WARN([No zlib package found, unable to use adler32 checksum])]
)
AC_SUBST(ZLIB)

# Super safe df
AC_ARG_ENABLE([mindf],
      AC_HELP_STRING([--enable-mindf],
                      [Make statfs report the minimum available space on any single OST instead of the sum of free space on all OSTs]),
      [],[])
if test "$enable_mindf" = "yes" ;  then
      AC_DEFINE([MIN_DF], 1, [Report minimum OST free space])
fi

AC_ARG_ENABLE([fail_alloc],
        AC_HELP_STRING([--disable-fail-alloc],
                [disable randomly alloc failure]),
        [],[enable_fail_alloc=yes])
AC_MSG_CHECKING([whether to randomly failing memory alloc])
AC_MSG_RESULT([$enable_fail_alloc])
if test x$enable_fail_alloc != xno ; then
        AC_DEFINE([RANDOM_FAIL_ALLOC], 1, [enable randomly alloc failure])
fi

AC_ARG_ENABLE([invariants],
        AC_HELP_STRING([--enable-invariants],
                [enable invariant checking (cpu intensive)]),
        [],[])
AC_MSG_CHECKING([whether to check invariants (expensive cpu-wise)])
AC_MSG_RESULT([$enable_invariants])
if test x$enable_invariants = xyes ; then
        AC_DEFINE([INVARIANT_CHECK], 1, [enable invariant checking])
fi

AC_ARG_ENABLE([lu_ref],
        AC_HELP_STRING([--enable-lu_ref],
                [enable lu_ref reference tracking code]),
        [],[])
AC_MSG_CHECKING([whether to track references with lu_ref])
AC_MSG_RESULT([$enable_lu_ref])
if test x$enable_lu_ref = xyes ; then
        AC_DEFINE([USE_LU_REF], 1, [enable lu_ref reference tracking code])
fi

AC_ARG_ENABLE([pgstate-track],
              AC_HELP_STRING([--enable-pgstate-track],
                             [enable page state tracking]),
              [enable_pgstat_track='yes'],[])
AC_MSG_CHECKING([whether to enable page state tracking])
AC_MSG_RESULT([$enable_pgstat_track])
if test x$enable_pgstat_track = xyes ; then
        AC_DEFINE([CONFIG_DEBUG_PAGESTATE_TRACKING], 1,
                  [enable page state tracking code])
fi

         #2.6.29
         LC_WRITE_BEGIN_END
         LC_D_OBTAIN_ALIAS
         LC_BLKDEV_PUT_2ARGS
         LC_DENTRY_OPEN_4ARGS
         LC_PAGEVEC_LRU_ADD_FILE

])

#
# LC_CONDITIONALS
#
# AM_CONDITIONALS for lustre
#
AC_DEFUN([LC_CONDITIONALS],
[AM_CONDITIONAL(LIBLUSTRE, test x$enable_liblustre = xyes)
AM_CONDITIONAL(USE_QUILT, test x$QUILT != xno)
AM_CONDITIONAL(LIBLUSTRE_TESTS, test x$enable_liblustre_tests = xyes)
AM_CONDITIONAL(MPITESTS, test x$enable_mpitests = xyes, Build MPI Tests)
AM_CONDITIONAL(CLIENT, test x$enable_client = xyes)
AM_CONDITIONAL(SERVER, test x$enable_server = xyes)
AM_CONDITIONAL(SPLIT, test x$enable_split = xyes)
AM_CONDITIONAL(BLKID, test x$ac_cv_header_blkid_blkid_h = xyes)
AM_CONDITIONAL(EXT2FS_DEVEL, test x$ac_cv_header_ext2fs_ext2fs_h = xyes)
AM_CONDITIONAL(GSS, test x$enable_gss = xyes)
AM_CONDITIONAL(GSS_KEYRING, test x$enable_gss_keyring = xyes)
AM_CONDITIONAL(GSS_PIPEFS, test x$enable_gss_pipefs = xyes)
AM_CONDITIONAL(LIBPTHREAD, test x$enable_libpthread = xyes)
AM_CONDITIONAL(LLITE_LLOOP, test x$enable_llite_lloop_module = xyes)
])

#
# LC_CONFIG_FILES
#
# files that should be generated with AC_OUTPUT
#
AC_DEFUN([LC_CONFIG_FILES],
[AC_CONFIG_FILES([
lustre/Makefile
lustre/autoMakefile
lustre/autoconf/Makefile
lustre/conf/Makefile
lustre/contrib/Makefile
lustre/doc/Makefile
lustre/include/Makefile
lustre/include/lustre_ver.h
lustre/include/linux/Makefile
lustre/include/darwin/Makefile
lustre/include/lustre/Makefile
lustre/kernel_patches/targets/2.6-rhel6.target
lustre/kernel_patches/targets/2.6-rhel5.target
lustre/kernel_patches/targets/2.6-sles11.target
lustre/kernel_patches/targets/3.0-sles11.target
lustre/kernel_patches/targets/2.6-fc11.target
lustre/kernel_patches/targets/2.6-fc12.target
lustre/kernel_patches/targets/2.6-fc15.target
lustre/kernel_patches/targets/3.x-fc18.target
lustre/ldlm/Makefile
lustre/fid/Makefile
lustre/fid/autoMakefile
lustre/liblustre/Makefile
lustre/liblustre/tests/Makefile
lustre/liblustre/tests/mpi/Makefile
lustre/llite/Makefile
lustre/llite/autoMakefile
lustre/lclient/Makefile
lustre/lov/Makefile
lustre/lov/autoMakefile
lustre/lvfs/Makefile
lustre/lvfs/autoMakefile
lustre/mdc/Makefile
lustre/mdc/autoMakefile
lustre/lmv/Makefile
lustre/lmv/autoMakefile
lustre/mdt/Makefile
lustre/mdt/autoMakefile
lustre/mdd/Makefile
lustre/mdd/autoMakefile
lustre/fld/Makefile
lustre/fld/autoMakefile
lustre/obdclass/Makefile
lustre/obdclass/autoMakefile
lustre/obdclass/linux/Makefile
lustre/obdecho/Makefile
lustre/obdecho/autoMakefile
lustre/ofd/Makefile
lustre/ofd/autoMakefile
lustre/osc/Makefile
lustre/osc/autoMakefile
lustre/ost/Makefile
lustre/ost/autoMakefile
lustre/osd-ldiskfs/Makefile
lustre/osd-ldiskfs/autoMakefile
lustre/osd-zfs/Makefile
lustre/osd-zfs/autoMakefile
lustre/mgc/Makefile
lustre/mgc/autoMakefile
lustre/mgs/Makefile
lustre/mgs/autoMakefile
lustre/target/Makefile
lustre/ptlrpc/Makefile
lustre/ptlrpc/autoMakefile
lustre/ptlrpc/gss/Makefile
lustre/ptlrpc/gss/autoMakefile
lustre/quota/Makefile
lustre/quota/autoMakefile
lustre/scripts/Makefile
lustre/tests/Makefile
lustre/tests/mpi/Makefile
lustre/utils/Makefile
lustre/utils/gss/Makefile
lustre/osp/Makefile
lustre/osp/autoMakefile
lustre/lod/Makefile
lustre/lod/autoMakefile
lustre/obdclass/darwin/Makefile
])
])

#
# LN_CONFIG_MAX_PAYLOAD
#
# configure maximum payload
#
AC_DEFUN([LN_CONFIG_MAX_PAYLOAD],
[AC_MSG_CHECKING([for non-default maximum LNET payload])
AC_ARG_WITH([max-payload-mb],
	AC_HELP_STRING([--with-max-payload-mb=MBytes],
                       [set maximum lnet payload in MBytes]),
        [
		AC_MSG_RESULT([$with_max_payload_mb])
	        LNET_MAX_PAYLOAD_MB=$with_max_payload_mb
		LNET_MAX_PAYLOAD="(($with_max_payload_mb)<<20)"
	], [
		AC_MSG_RESULT([no])
		LNET_MAX_PAYLOAD="LNET_MTU"
	])
        AC_DEFINE_UNQUOTED(LNET_MAX_PAYLOAD, $LNET_MAX_PAYLOAD,
			   [Max LNET payload])
])

#
# LN_CHECK_GCC_VERSION
#
# Check compiler version
#
AC_DEFUN([LN_CHECK_GCC_VERSION],
[AC_MSG_CHECKING([compiler version])
PTL_CC_VERSION=`$CC --version | awk '/^gcc/{print $ 3}'`
PTL_MIN_CC_VERSION="3.2.2"
v2n() {
	awk -F. '{printf "%d\n", (($ 1)*100+($ 2))*100+($ 3)}'
}
if test -z "$PTL_CC_VERSION" -o \
        `echo $PTL_CC_VERSION | v2n` -ge `echo $PTL_MIN_CC_VERSION | v2n`; then
	AC_MSG_RESULT([ok])
else
	AC_MSG_RESULT([Buggy compiler found])
	AC_MSG_ERROR([Need gcc version >= $PTL_MIN_CC_VERSION])
fi
])

#
# LN_FUNC_DEV_GET_BY_NAME_2ARG
#
AC_DEFUN([LN_FUNC_DEV_GET_BY_NAME_2ARG],
[AC_MSG_CHECKING([if dev_get_by_name has two args])
LB_LINUX_TRY_COMPILE([
	#include <linux/netdevice.h>
],[
        dev_get_by_name(NULL, NULL);
],[
	AC_MSG_RESULT([yes])
	AC_DEFINE(HAVE_DEV_GET_BY_NAME_2ARG, 1, [dev_get_by_name has 2 args])
],[
	AC_MSG_RESULT([no])
])
])

#
# LN_CONFIG_AFFINITY
#
# check if cpu affinity is available/wanted
#
AC_DEFUN([LN_CONFIG_AFFINITY],
[AC_ARG_ENABLE([affinity],
	AC_HELP_STRING([--disable-affinity],
		       [disable process/irq affinity]),
	[],[enable_affinity='yes'])

AC_MSG_CHECKING([for CPU affinity support])
if test x$enable_affinity = xno ; then
	AC_MSG_RESULT([no (by request)])
else
	LB_LINUX_TRY_COMPILE([
		#include <linux/sched.h>
	],[
		struct task_struct t;
		#if HAVE_CPUMASK_T
		cpumask_t     m;
	        #else
	        unsigned long m;
		#endif
		set_cpus_allowed(&t, m);
	],[
		AC_DEFINE(CPU_AFFINITY, 1, [kernel has cpu affinity support])
		AC_MSG_RESULT([yes])
	],[
		AC_MSG_RESULT([no (no kernel support)])
	])
fi
])

#
# LN_CONFIG_PORTALS
#
# configure support for Portals
#
AC_DEFUN([LN_CONFIG_PORTALS],
[AC_MSG_CHECKING([for portals])
AC_ARG_WITH([portals],
	AC_HELP_STRING([--with-portals=path],
                       [set path to portals]),
        [
		case $with_portals in
			no)     ENABLEPORTALS=0
				;;
			*)	PORTALS="${with_portals}"
				ENABLEPORTALS=1
				;;
		esac
	], [
		ENABLEPORTALS=0
	])
PTLLNDCPPFLAGS=""
if test $ENABLEPORTALS -eq 0; then
	AC_MSG_RESULT([no])
elif test ! \( -f ${PORTALS}/include/portals/p30.h \); then
	AC_MSG_RESULT([no])
	AC_MSG_ERROR([bad --with-portals path])
else
	PORTALS=$(readlink --canonicalize $PORTALS)
	AC_MSG_RESULT([$PORTALS])
	PTLLNDCPPFLAGS="-I${PORTALS}/include"
fi
AC_SUBST(PTLLNDCPPFLAGS)
])

#
# LN_CONFIG_BACKOFF
#
# check if tunable tcp backoff is available/wanted
#
AC_DEFUN([LN_CONFIG_BACKOFF],
[AC_MSG_CHECKING([for tunable backoff TCP support])
AC_ARG_ENABLE([backoff],
       AC_HELP_STRING([--disable-backoff],
                      [disable socknal tunable backoff]),
       [],[enable_backoff='yes'])
if test x$enable_backoff = xno ; then
       AC_MSG_RESULT([no (by request)])
else
       BOCD="`grep -c TCP_BACKOFF $LINUX/include/linux/tcp.h`"
       if test "$BOCD" != 0 ; then
               AC_DEFINE(SOCKNAL_BACKOFF, 1, [use tunable backoff TCP])
               AC_MSG_RESULT(yes)
               if grep rto_max $LINUX/include/linux/tcp.h|grep -q __u16; then
                   AC_DEFINE(SOCKNAL_BACKOFF_MS, 1, [tunable backoff TCP in ms])
               fi
       else
               AC_MSG_RESULT([no (no kernel support)])
       fi
fi
])


#
# LN_CONFIG_PTLLND
#
# configure support for Portals LND
#
AC_DEFUN([LN_CONFIG_PTLLND],
[
if test -z "$ENABLEPORTALS"; then
	LN_CONFIG_PORTALS
fi

AC_MSG_CHECKING([whether to build the kernel portals LND])

PTLLND=""
if test $ENABLEPORTALS -ne 0; then
	AC_MSG_RESULT([yes])
	PTLLND="ptllnd"
else
	AC_MSG_RESULT([no])
fi
AC_SUBST(PTLLND)
])

#
# LN_CONFIG_UPTLLND
#
# configure support for Portals LND
#
AC_DEFUN([LN_CONFIG_UPTLLND],
[
if test -z "$ENABLEPORTALS"; then
	LN_CONFIG_PORTALS
fi

AC_MSG_CHECKING([whether to build the userspace portals LND])

UPTLLND=""
if test $ENABLEPORTALS -ne 0; then
	AC_MSG_RESULT([yes])
	UPTLLND="ptllnd"
else
	AC_MSG_RESULT([no])
fi
AC_SUBST(UPTLLND)
])

#
# LN_CONFIG_USOCKLND
#
# configure support for userspace TCP/IP LND
#
AC_DEFUN([LN_CONFIG_USOCKLND],
[AC_MSG_CHECKING([whether to build usocklnd])
AC_ARG_ENABLE([usocklnd],
       	AC_HELP_STRING([--disable-usocklnd],
                      	[disable usocklnd]),
       	[],[enable_usocklnd='yes'])

if test x$enable_usocklnd = xyes ; then
	if test "$ENABLE_LIBPTHREAD" = "yes" ; then
		AC_MSG_RESULT([yes])
      		USOCKLND="usocklnd"
	else
		AC_MSG_RESULT([no (libpthread not present or disabled)])
		USOCKLND=""
	fi
else
	AC_MSG_RESULT([no (disabled explicitly)])
     	USOCKLND=""
fi
AC_SUBST(USOCKLND)
])

#
# LN_CONFIG_QUADRICS
#
# check if quadrics support is in this kernel
#
AC_DEFUN([LN_CONFIG_QUADRICS],
[AC_MSG_CHECKING([for QsNet sources])
AC_ARG_WITH([qsnet],
	AC_HELP_STRING([--with-qsnet=path],
		       [set path to qsnet source (default=$LINUX)]),
	[QSNET=$with_qsnet],
	[QSNET=$LINUX])
AC_MSG_RESULT([$QSNET])

AC_MSG_CHECKING([if quadrics kernel headers are present])
if test -d $QSNET/drivers/net/qsnet ; then
	AC_MSG_RESULT([yes])
	QSWLND="qswlnd"
	AC_MSG_CHECKING([for multirail EKC])
	if test -f $QSNET/include/elan/epcomms.h; then
		QSNET=$(readlink --canonicalize $QSNET)
		AC_MSG_RESULT([supported])
		QSWCPPFLAGS="-I$QSNET/include -DMULTIRAIL_EKC=1"
	else
		AC_MSG_RESULT([not supported])
		AC_MSG_ERROR([Need multirail EKC])
	fi

	if test x$QSNET = x$LINUX ; then
		LB_LINUX_CONFIG([QSNET],[],[
			LB_LINUX_CONFIG([QSNET_MODULE],[],[
				AC_MSG_WARN([QSNET is not enabled in this kernel; not building qswlnd.])
				QSWLND=""
				QSWCPPFLAGS=""
			])
		])
	fi
else
	AC_MSG_RESULT([no])
	QSWLND=""
	QSWCPPFLAGS=""
fi
AC_SUBST(QSWCPPFLAGS)
AC_SUBST(QSWLND)
])


#
# LN_CONFIG_MX
#
AC_DEFUN([LN_CONFIG_MX],
[AC_MSG_CHECKING([whether to enable Myrinet MX support])
# set default
MXPATH="/opt/mx"
AC_ARG_WITH([mx],
       AC_HELP_STRING([--with-mx=path],
                      [build mxlnd against path]),
       [
               case $with_mx in
               yes)    ENABLEMX=2
                       ;;
               no)     ENABLEMX=0
                       ;;
               *)      MXPATH=$with_mx
                       ENABLEMX=3
                       ;;
               esac
       ],[
               ENABLEMX=1
       ])
if test $ENABLEMX -eq 0; then
       AC_MSG_RESULT([disabled])
elif test ! \( -f ${MXPATH}/include/myriexpress.h -a \
              -f ${MXPATH}/include/mx_kernel_api.h -a \
              -f ${MXPATH}/include/mx_pin.h \); then
       AC_MSG_RESULT([no])
       case $ENABLEMX in
       1) ;;
       2) AC_MSG_ERROR([Myrinet MX kernel headers not present]);;
       3) AC_MSG_ERROR([bad --with-mx path]);;
       *) AC_MSG_ERROR([internal error]);;
       esac
else
       MXPATH=$(readlink --canonicalize $MXPATH)
       MXCPPFLAGS="-I$MXPATH/include"
       EXTRA_KCFLAGS_save="$EXTRA_KCFLAGS"
       EXTRA_KCFLAGS="$EXTRA_KCFLAGS $MXCPPFLAGS"
       MXLIBS="-L$MXPATH/lib"
       LB_LINUX_TRY_COMPILE([
               #define MX_KERNEL 1
               #include <mx_extensions.h>
               #include <myriexpress.h>
       ],[
               mx_endpoint_t   end;
               mx_status_t     status;
               mx_request_t    request;
               int             result;

               mx_init();
               mx_open_endpoint(MX_ANY_NIC, MX_ANY_ENDPOINT, 0, NULL, 0, &end);
	       mx_register_unexp_handler(end, (mx_unexp_handler_t) NULL, NULL);
               mx_wait_any(end, MX_INFINITE, 0LL, 0LL, &status, &result);
               mx_iconnect(end, 0LL, 0, 0, 0, NULL, &request);
               return 0;
       ],[
               AC_MSG_RESULT([yes])
               MXLND="mxlnd"
       ],[
               AC_MSG_RESULT([no])
               case $ENABLEMX in
               1) ;;
               2) AC_MSG_ERROR([can't compile with Myrinet MX kernel headers]);;
               3) AC_MSG_ERROR([can't compile with Myrinet MX headers under $MXPATH]);;
               *) AC_MSG_ERROR([internal error]);;
               esac
               MXLND=""
               MXCPPFLAGS=""
       ])
       EXTRA_KCFLAGS="$EXTRA_KCFLAGS_save"
fi
AC_SUBST(MXCPPFLAGS)
AC_SUBST(MXLIBS)
AC_SUBST(MXLND)
])



#
# LN_CONFIG_O2IB
#
AC_DEFUN([LN_CONFIG_O2IB],[

AC_MSG_CHECKING([whether to enable OpenIB gen2 support])
# set default
AC_ARG_WITH([o2ib],
	AC_HELP_STRING([--with-o2ib=path],
	               [build o2iblnd against path]),
	[
		case $with_o2ib in
		yes)    O2IBPATHS="$LINUX $LINUX/drivers/infiniband"
			ENABLEO2IB=2
			;;
		no)     ENABLEO2IB=0
			;;
		*)      O2IBPATHS=$with_o2ib
			ENABLEO2IB=3
			;;
		esac
	],[
		O2IBPATHS="$LINUX $LINUX/drivers/infiniband"
		ENABLEO2IB=1
	])
if test $ENABLEO2IB -eq 0; then
	AC_MSG_RESULT([disabled])
else
	o2ib_found=false
	for O2IBPATH in $O2IBPATHS; do
		if test \( -f ${O2IBPATH}/include/rdma/rdma_cm.h -a \
			   -f ${O2IBPATH}/include/rdma/ib_cm.h -a \
			   -f ${O2IBPATH}/include/rdma/ib_verbs.h -a \
			   -f ${O2IBPATH}/include/rdma/ib_fmr_pool.h \); then
			if test \( -d ${O2IBPATH}/kernel_patches -a \
				   -f ${O2IBPATH}/Makefile \); then
				AC_MSG_RESULT([no])
				AC_MSG_ERROR([you appear to be trying to use the OFED distribution's source directory (${O2IBPATH}) rather than the "development/headers" directory which is likely in ${O2IBPATH%-*}])
			fi
			o2ib_found=true
			break
 		fi
	done
	if ! $o2ib_found; then
		AC_MSG_RESULT([no])
		case $ENABLEO2IB in
			1) ;;
			2) AC_MSG_ERROR([kernel OpenIB gen2 headers not present]);;
			3) AC_MSG_ERROR([bad --with-o2ib path]);;
			*) AC_MSG_ERROR([internal error]);;
		esac
	else
		O2IBPATH=$(readlink --canonicalize $O2IBPATH)
		O2IBCPPFLAGS="-I$O2IBPATH/include"
		EXTRA_KCFLAGS_save="$EXTRA_KCFLAGS"
		EXTRA_KCFLAGS="$EXTRA_KCFLAGS $O2IBCPPFLAGS"
		EXTRA_LNET_INCLUDE="$EXTRA_LNET_INCLUDE $O2IBCPPFLAGS"

		LB_LINUX_TRY_COMPILE([
		        #include <linux/version.h>
		        #include <linux/pci.h>
			#include <linux/gfp.h>
			#ifdef HAVE_COMPAT_RDMA
			#include <linux/compat-2.6.h>
			#endif
		        #include <rdma/rdma_cm.h>
		        #include <rdma/ib_cm.h>
		        #include <rdma/ib_verbs.h>
		        #include <rdma/ib_fmr_pool.h>
		],[
		        struct rdma_cm_id      *cm_idi __attribute__ ((unused));
		        struct rdma_conn_param  conn_param __attribute__ ((unused));
		        struct ib_device_attr   device_attr __attribute__ ((unused));
		        struct ib_qp_attr       qp_attr __attribute__ ((unused));
		        struct ib_pool_fmr      pool_fmr __attribute__ ((unused));
		        enum   ib_cm_rej_reason rej_reason __attribute__ ((unused));

			rdma_destroy_id(NULL);
		],[
		        AC_MSG_RESULT([yes])
		        O2IBLND="o2iblnd"
		],[
		        AC_MSG_RESULT([no])
		        case $ENABLEO2IB in
		        1) ;;
		        2) AC_MSG_ERROR([can't compile with kernel OpenIB gen2 headers]);;
		        3) AC_MSG_ERROR([can't compile with OpenIB gen2 headers under $O2IBPATH]);;
		        *) AC_MSG_ERROR([internal error]);;
		        esac
		        O2IBLND=""
		        O2IBCPPFLAGS=""
		])
		# we know at this point that the found OFED source is good
		O2IB_SYMVER=""
		if test $ENABLEO2IB -eq 3 ; then
			# OFED default rpm not handle sles10 Modules.symvers name
			for name in Module.symvers Modules.symvers; do
				if test -f $O2IBPATH/$name; then
					O2IB_SYMVER=$name;
					break;
				fi
			done
			if test -n "$O2IB_SYMVER"; then
				AC_MSG_NOTICE([adding $O2IBPATH/$O2IB_SYMVER to $PWD/$SYMVERFILE])
				# strip out the existing symbols versions first
				if test -f $PWD/$SYMVERFILE; then
				egrep -v $(echo $(awk '{ print $2 }' $O2IBPATH/$O2IB_SYMVER) | tr ' ' '|') $PWD/$SYMVERFILE > $PWD/$SYMVERFILE.old
				else
				    touch $PWD/$SYMVERFILE.old
				fi
				cat $PWD/$SYMVERFILE.old $O2IBPATH/$O2IB_SYMVER > $PWD/$SYMVERFILE
				rm $PWD/$SYMVERFILE.old
			else
				AC_MSG_ERROR([an external source tree was specified for o2iblnd however I could not find a $O2IBPATH/Module.symvers there])
			fi
		fi

		LN_CONFIG_OFED_SPEC
		EXTRA_KCFLAGS="$EXTRA_KCFLAGS_save"
	fi
fi

AC_SUBST(EXTRA_LNET_INCLUDE)
AC_SUBST(O2IBCPPFLAGS)
AC_SUBST(O2IBLND)

# In RHEL 6.2, rdma_create_id() takes the queue-pair type as a fourth argument
if test $ENABLEO2IB -ne 0; then
	AC_MSG_CHECKING([if rdma_create_id wants four args])
	LB_LINUX_TRY_COMPILE([
		#ifdef HAVE_COMPAT_RDMA
		#include <linux/compat-2.6.h>
		#endif
		#include <rdma/rdma_cm.h>
	],[
		rdma_create_id(NULL, NULL, 0, 0);
	],[
		AC_MSG_RESULT([yes])
		AC_DEFINE(HAVE_RDMA_CREATE_ID_4ARG, 1,
			[rdma_create_id wants 4 args])
	],[
		AC_MSG_RESULT([no])
	])
fi
])

#
# LN_CONFIG_RALND
#
# check whether to use the RapidArray lnd
#
AC_DEFUN([LN_CONFIG_RALND],
[#### Rapid Array
AC_MSG_CHECKING([if RapidArray kernel headers are present])
# placeholder
RACPPFLAGS="-I${LINUX}/drivers/xd1/include"
EXTRA_KCFLAGS_save="$EXTRA_KCFLAGS"
EXTRA_KCFLAGS="$EXTRA_KCFLAGS $RACPPFLAGS"
LB_LINUX_TRY_COMPILE([
	#include <linux/types.h>
	#include <rapl.h>
],[
        RAP_RETURN          rc;
	RAP_PVOID           dev_handle;

        rc = RapkGetDeviceByIndex(0, NULL, &dev_handle);

	return rc == RAP_SUCCESS ? 0 : 1;
],[
	AC_MSG_RESULT([yes])
	RALND="ralnd"
],[
	AC_MSG_RESULT([no])
	RALND=""
	RACPPFLAGS=""
])
EXTRA_KCFLAGS="$EXTRA_KCFLAGS_save"
AC_SUBST(RACPPFLAGS)
AC_SUBST(RALND)
])

#
# LN_CONFIG_GNILND
#
# check whether to use the Gemini Network Interface lnd
#
AC_DEFUN([LN_CONFIG_GNILND],
[#### Gemini Network Interface
AC_MSG_CHECKING([whether to enable GNI lnd])
AC_ARG_ENABLE([gni],
	AC_HELP_STRING([--enable-gni],
			[enable GNI lnd]),
	[],[enable_gni='no'])
AC_MSG_RESULT([$enable_gni])

if test x$enable_gni = xyes ; then
	AC_MSG_CHECKING([if GNI kernel headers are present])
	# placeholder
	# GNICPPFLAGS was set in spec file
	EXTRA_KCFLAGS_save="$EXTRA_KCFLAGS"
	EXTRA_KCFLAGS="$EXTRA_KCFLAGS $GNICPPFLAGS"
	LB_LINUX_TRY_COMPILE([
		#include <linux/types.h>
		#include <gni_pub.h>
	],[
		gni_cdm_handle_t	kgni_domain;
		gni_return_t		rc;
		int			rrc;

		rc = gni_cdm_create(0, 1, 1, 0, &kgni_domain);

		rrc = (rc == GNI_RC_SUCCESS) ? 0 : 1;

		return rrc;
	],[
		AC_MSG_RESULT([yes])
		GNILND="gnilnd"
	],[
		AC_MSG_RESULT([no])
		AC_MSG_ERROR([can't compile gnilnd with given GNICPPFLAGS: $GNICPPFLAGS])
	])
	# at this point, we have gnilnd basic support, now check for extra features
	AC_MSG_CHECKING([to use RCA in gnilnd])
	LB_LINUX_TRY_COMPILE([
		#include <linux/types.h>
		#include <gni_pub.h>
		#include <krca_lib.h>
	],[
		gni_cdm_handle_t	kgni_domain;
		gni_return_t		rc;
		krca_ticket_t		ticket = KRCA_NULL_TICKET;
		int			rrc;
		__u32			nid = 0, nic_addr;

		rc = gni_cdm_create(0, 1, 1, 0, &kgni_domain);

		rrc = (rc == GNI_RC_SUCCESS) ? 0 : 1;

		rrc += krca_nid_to_nicaddrs(nid, 1, &nic_addr);

		rrc += krca_register(&ticket, RCA_MAKE_SERVICE_INDEX(RCA_IO_CLASS, 9), 99, 0);

		return rrc;
	],[
		AC_MSG_RESULT([yes])
		GNICPPFLAGS="$GNICPPFLAGS -DGNILND_USE_RCA=1"
		GNILNDRCA="gnilndrca"
	],[
		AC_MSG_RESULT([no])
	])
	EXTRA_KCFLAGS="$EXTRA_KCFLAGS_save"
fi
AC_SUBST(GNICPPFLAGS)
AC_SUBST(GNILNDRCA)
AC_SUBST(GNILND)
])


#
#
# LN_CONFIG_USERSPACE
#
# This is defined but empty because it is called from
# build/autconf/lustre-build.m4 which is shared by all branches.
#
AC_DEFUN([LN_CONFIG_USERSPACE],
[
])

# See if sysctl proc_handler wants only 5 arguments (since 2.6.32)
AC_DEFUN([LN_5ARGS_SYSCTL_PROC_HANDLER],
[AC_MSG_CHECKING([if sysctl proc_handler wants 5 args])
LB_LINUX_TRY_COMPILE([
        #include <linux/sysctl.h>
],[
        struct ctl_table *table = NULL;
        int write = 1;
        void __user *buffer = NULL;
        size_t *lenp = NULL;
        loff_t *ppos = NULL;

        proc_handler *proc_handler = NULL;
        proc_handler(table, write, buffer, lenp, ppos);

],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_5ARGS_SYSCTL_PROC_HANDLER, 1,
                  [sysctl proc_handler wants 5 args])
],[
        AC_MSG_RESULT(no)
])
])

#
# 2.6.36 tcp_sendpage() first parameter is 'struct sock' instead of 'struct socket'.
#
AC_DEFUN([LN_CONFIG_TCP_SENDPAGE],
[AC_MSG_CHECKING([if tcp_sendpage first parameter is socket])
tmp_flags="$EXTRA_KCFLAGS"
EXTRA_KCFLAGS="-Werror"
LB_LINUX_TRY_COMPILE([
        #include <linux/net.h>
        #include <net/tcp.h>
],[
        tcp_sendpage((struct socket*)0, NULL, 0, 0, 0);
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_TCP_SENDPAGE_USE_SOCKET, 1,
                  [tcp_sendpage use socket as first parameter])
],[
        AC_MSG_RESULT(no)
])
EXTRA_KCFLAGS="$tmp_flags"
])

#
# LN_PROG_LINUX
#
# LNet linux kernel checks
#
AC_DEFUN([LN_PROG_LINUX],
[
LN_FUNC_DEV_GET_BY_NAME_2ARG
LN_CONFIG_AFFINITY
LN_CONFIG_BACKOFF
LN_CONFIG_QUADRICS
LN_CONFIG_O2IB
LN_CONFIG_RALND
LN_CONFIG_GNILND
LN_CONFIG_PTLLND
LN_CONFIG_MX
# 2.6.32
LN_5ARGS_SYSCTL_PROC_HANDLER
# 2.6.36
LN_CONFIG_TCP_SENDPAGE
])

#
# LN_PROG_DARWIN
#
# Darwin checks
#
AC_DEFUN([LN_PROG_DARWIN],
[LB_DARWIN_CHECK_FUNCS([get_preemption_level])
])

#
# LN_PATH_DEFAULTS
#
# default paths for installed files
#
AC_DEFUN([LN_PATH_DEFAULTS],
[
])

#
# LN_CONFIGURE
#
# other configure checks
#
AC_DEFUN([LN_CONFIGURE],
[# lnet/utils/portals.c
AC_CHECK_HEADERS([netdb.h netinet/tcp.h asm/types.h endian.h sys/ioctl.h])
AC_CHECK_FUNCS([gethostbyname socket connect])

# lnet/utils/debug.c
AC_CHECK_HEADERS([linux/version.h])

# lnet/utils/wirecheck.c
AC_CHECK_FUNCS([strnlen])

# --------  Check for required packages  --------------

#
# LC_CONFIG_READLINE
#
# Build with readline
#
AC_MSG_CHECKING([whether to enable readline support])
AC_ARG_ENABLE(readline,
        AC_HELP_STRING([--disable-readline],
                        [disable readline support]),
        [],[enable_readline='yes'])
AC_MSG_RESULT([$enable_readline])

# -------- check for readline if enabled ----
if test x$enable_readline = xyes ; then
	LIBS_save="$LIBS"
	LIBS="-lncurses $LIBS"
	AC_CHECK_LIB([readline],[readline],[
	LIBREADLINE="-lreadline -lncurses"
	AC_DEFINE(HAVE_LIBREADLINE, 1, [readline library is available])
	],[
	LIBREADLINE=""
	])
	LIBS="$LIBS_save"
else
	LIBREADLINE=""
fi
AC_SUBST(LIBREADLINE)

# -------- enable acceptor libwrap (TCP wrappers) support? -------
AC_MSG_CHECKING([if libwrap support is requested])
AC_ARG_ENABLE([libwrap],
	AC_HELP_STRING([--enable-libwrap], [use TCP wrappers]),
	[case "${enableval}" in
		yes) enable_libwrap=yes ;;
		no) enable_libwrap=no ;;
		*) AC_MSG_ERROR(bad value ${enableval} for --enable-libwrap) ;;
	esac],[enable_libwrap=no])
AC_MSG_RESULT([$enable_libwrap])
if test x$enable_libwrap = xyes ; then
	LIBWRAP="-lwrap"
	AC_DEFINE(HAVE_LIBWRAP, 1, [libwrap support is requested])
else
	LIBWRAP=""
fi
AC_SUBST(LIBWRAP)

# ----------------------------------------
# some tests for catamount-like systems
# ----------------------------------------
AC_ARG_ENABLE([sysio_init],
	AC_HELP_STRING([--disable-sysio-init],
		[call sysio init functions when initializing liblustre]),
	[],[enable_sysio_init=yes])
AC_MSG_CHECKING([whether to initialize libsysio])
AC_MSG_RESULT([$enable_sysio_init])
if test x$enable_sysio_init != xno ; then
	AC_DEFINE([INIT_SYSIO], 1, [call sysio init functions])
fi

AC_ARG_ENABLE([urandom],
	AC_HELP_STRING([--disable-urandom],
		[disable use of /dev/urandom for liblustre]),
	[],[enable_urandom=yes])
AC_MSG_CHECKING([whether to use /dev/urandom for liblustre])
AC_MSG_RESULT([$enable_urandom])
if test x$enable_urandom != xno ; then
	AC_DEFINE([LIBLUSTRE_USE_URANDOM], 1, [use /dev/urandom for random data])
fi

# -------- check for -lcap support ----
if test x$enable_liblustre = xyes ; then
	AC_CHECK_LIB([cap], [cap_get_proc],
		[
			CAP_LIBS="-lcap"
			AC_DEFINE([HAVE_LIBCAP], 1, [use libcap])
		],
		[
			CAP_LIBS=""
		])
	AC_SUBST(CAP_LIBS)

fi

LN_CONFIG_MAX_PAYLOAD
LN_CONFIG_UPTLLND
LN_CONFIG_USOCKLND
])

#
# LN_CONDITIONALS
#
# AM_CONDITOINAL defines for lnet
#
AC_DEFUN([LN_CONDITIONALS],
[AM_CONDITIONAL(BUILD_QSWLND, test x$QSWLND = "xqswlnd")
AM_CONDITIONAL(BUILD_MXLND, test x$MXLND = "xmxlnd")
AM_CONDITIONAL(BUILD_O2IBLND, test x$O2IBLND = "xo2iblnd")
AM_CONDITIONAL(BUILD_RALND, test x$RALND = "xralnd")
AM_CONDITIONAL(BUILD_GNILND, test x$GNILND = "xgnilnd")
AM_CONDITIONAL(BUILD_GNILND_RCA, test x$GNILNDRCA = "xgnilndrca")
AM_CONDITIONAL(BUILD_PTLLND, test x$PTLLND = "xptllnd")
AM_CONDITIONAL(BUILD_USOCKLND, test x$USOCKLND = "xusocklnd")
])

#
# LN_CONFIG_FILES
#
# files that should be generated with AC_OUTPUT
#
AC_DEFUN([LN_CONFIG_FILES],
[AC_CONFIG_FILES([
lnet/Kernelenv
lnet/Makefile
lnet/autoMakefile
lnet/autoconf/Makefile
lnet/doc/Makefile
lnet/include/Makefile
lnet/include/lnet/Makefile
lnet/include/lnet/linux/Makefile
lnet/klnds/Makefile
lnet/klnds/autoMakefile
lnet/klnds/mxlnd/autoMakefile
lnet/klnds/mxlnd/Makefile
lnet/klnds/o2iblnd/Makefile
lnet/klnds/o2iblnd/autoMakefile
lnet/klnds/qswlnd/Makefile
lnet/klnds/qswlnd/autoMakefile
lnet/klnds/ralnd/Makefile
lnet/klnds/ralnd/autoMakefile
lnet/klnds/gnilnd/Makefile
lnet/klnds/gnilnd/autoMakefile
lnet/klnds/socklnd/Makefile
lnet/klnds/socklnd/autoMakefile
lnet/klnds/ptllnd/Makefile
lnet/klnds/ptllnd/autoMakefile
lnet/lnet/Makefile
lnet/lnet/autoMakefile
lnet/selftest/Makefile
lnet/selftest/autoMakefile
lnet/ulnds/Makefile
lnet/ulnds/autoMakefile
lnet/ulnds/socklnd/Makefile
lnet/utils/Makefile
lnet/include/lnet/darwin/Makefile
])
])

dnl Checks for OFED
AC_DEFUN([LN_CONFIG_OFED_SPEC],
[
	AC_MSG_CHECKING([if OFED has ib_dma_map_single])
	LB_LINUX_TRY_COMPILE([
		#include <linux/version.h>
		#include <linux/pci.h>
		#include <linux/gfp.h>
		#include <rdma/ib_verbs.h>
	],[
		ib_dma_map_single(NULL, NULL, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_OFED_IB_DMA_MAP, 1,
			  [ib_dma_map_single defined])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if ib_create_cq wants comp_vector])
	LB_LINUX_TRY_COMPILE([
		#include <linux/version.h>
		#include <linux/pci.h>
		#include <linux/gfp.h>
		#include <rdma/ib_verbs.h>
	],[
		ib_create_cq(NULL, NULL, NULL, NULL, 0, 0);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_OFED_IB_COMP_VECTOR, 1,
			  [has completion vector])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if OFED has RDMA_CM_EVENT_ADDR_CHANGE])
	LB_LINUX_TRY_COMPILE([
		#include <linux/version.h>
		#include <linux/pci.h>
		#include <linux/gfp.h>
		#include <rdma/rdma_cm.h>
	],[
		return (RDMA_CM_EVENT_ADDR_CHANGE == 0);
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_OFED_RDMA_CMEV_ADDRCHANGE, 1,
			  [has completion vector])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if OFED has RDMA_CM_EVENT_TIMEWAIT_EXIT])
	LB_LINUX_TRY_COMPILE([
		#include <linux/version.h>
		#include <linux/pci.h>
		#include <linux/gfp.h>
		#include <rdma/rdma_cm.h>
	],[
		return (RDMA_CM_EVENT_TIMEWAIT_EXIT == 0);
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_OFED_RDMA_CMEV_TIMEWAIT_EXIT, 1,
			  [has completion vector])
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([if OFED has rdma_set_reuseaddr])
	LB_LINUX_TRY_COMPILE([
		#include <linux/version.h>
		#include <linux/pci.h>
		#include <linux/gfp.h>
		#include <rdma/rdma_cm.h>
	],[
		rdma_set_reuseaddr(NULL, 1);
		return 0;
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_OFED_RDMA_SET_REUSEADDR, 1,
			  [rdma_set_reuse defined])
	],[
		AC_MSG_RESULT(no)
	])
])

#
# LN_CONFIG_CDEBUG
#
# whether to enable various libcfs debugs (CDEBUG, ENTRY/EXIT, LASSERT, etc.)
#
AC_DEFUN([LN_CONFIG_CDEBUG],
[
AC_MSG_CHECKING([whether to enable CDEBUG, CWARN])
AC_ARG_ENABLE([libcfs_cdebug],
	AC_HELP_STRING([--disable-libcfs-cdebug],
			[disable libcfs CDEBUG, CWARN]),
	[],[enable_libcfs_cdebug='yes'])
AC_MSG_RESULT([$enable_libcfs_cdebug])
if test x$enable_libcfs_cdebug = xyes; then
   AC_DEFINE(CDEBUG_ENABLED, 1, [enable libcfs CDEBUG, CWARN])
else
   AC_DEFINE(CDEBUG_ENABLED, 0, [disable libcfs CDEBUG, CWARN])
fi

AC_MSG_CHECKING([whether to enable ENTRY/EXIT])
AC_ARG_ENABLE([libcfs_trace],
	AC_HELP_STRING([--disable-libcfs-trace],
			[disable libcfs ENTRY/EXIT]),
	[],[enable_libcfs_trace='yes'])
AC_MSG_RESULT([$enable_libcfs_trace])
if test x$enable_libcfs_trace = xyes; then
   AC_DEFINE(CDEBUG_ENTRY_EXIT, 1, [enable libcfs ENTRY/EXIT])
else
   AC_DEFINE(CDEBUG_ENTRY_EXIT, 0, [disable libcfs ENTRY/EXIT])
fi

AC_MSG_CHECKING([whether to enable LASSERT, LASSERTF])
AC_ARG_ENABLE([libcfs_assert],
	AC_HELP_STRING([--disable-libcfs-assert],
			[disable libcfs LASSERT, LASSERTF]),
	[],[enable_libcfs_assert='yes'])
AC_MSG_RESULT([$enable_libcfs_assert])
if test x$enable_libcfs_assert = xyes; then
   AC_DEFINE(LIBCFS_DEBUG, 1, [enable libcfs LASSERT, LASSERTF])
fi
])

#
# LIBCFS_CONFIG_PANIC_DUMPLOG
#
# check if tunable panic_dumplog is wanted
#
AC_DEFUN([LIBCFS_CONFIG_PANIC_DUMPLOG],
[AC_MSG_CHECKING([for tunable panic_dumplog support])
AC_ARG_ENABLE([panic_dumplog],
       AC_HELP_STRING([--enable-panic_dumplog],
                      [enable panic_dumplog]),
       [],[enable_panic_dumplog='no'])
if test x$enable_panic_dumplog = xyes ; then
       AC_DEFINE(LNET_DUMP_ON_PANIC, 1, [use dumplog on panic])
       AC_MSG_RESULT([yes (by request)])
else
       AC_MSG_RESULT([no])
fi
])

# check kernel __u64 type
AC_DEFUN([LIBCFS_U64_LONG_LONG_LINUX],
[
AC_MSG_CHECKING([kernel __u64 is long long type])
tmp_flags="$EXTRA_KCFLAGS"
EXTRA_KCFLAGS="$EXTRA_KCFLAGS -Werror"
LB_LINUX_TRY_COMPILE([
	#include <linux/types.h>
	#include <linux/stddef.h>
],[
	unsigned long long *data;

	data = (__u64*)sizeof(data);
],[
	AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_KERN__U64_LONG_LONG, 1,
                  [kernel __u64 is long long type])
],[
	AC_MSG_RESULT([no])
])
EXTRA_KCFLAGS="$tmp_flags"
])

# LIBCFS_TASKLIST_LOCK
# 2.6.18 remove tasklist_lock export
AC_DEFUN([LIBCFS_TASKLIST_LOCK],
[LB_CHECK_SYMBOL_EXPORT([tasklist_lock],
[kernel/fork.c],[
AC_DEFINE(HAVE_TASKLIST_LOCK, 1,
         [tasklist_lock exported])
],[
])
])

# LIBCFS_DIGEST_SETKEY_FLAGS
# digest_alg.dia_setkey takes 4 args (2.6.18)
#
AC_DEFUN([LIBCFS_DIGEST_SETKEY_FLAGS],
[AC_MSG_CHECKING([if kernel dia_setkey takes 4 args])
LB_LINUX_TRY_COMPILE([
	#include <linux/err.h>
	#include <linux/crypto.h>
],[
	struct digest_alg alg;

	alg.dia_setkey(NULL, NULL, 0, NULL);
],[
	AC_MSG_RESULT([yes])
	AC_DEFINE(HAVE_DIGEST_SETKEY_FLAGS, 1, [kernel dia_setkey takes 4 args])
],[
	AC_MSG_RESULT([no])
])
])

# 2.6.19 API changes
# kmem_cache_destroy(cachep) return void instead of
# int
AC_DEFUN([LIBCFS_KMEM_CACHE_DESTROY_INT],
[AC_MSG_CHECKING([kmem_cache_destroy(cachep) return int])
LB_LINUX_TRY_COMPILE([
        #include <linux/slab.h>
],[
	int i __attribute__ ((unused));
	i = kmem_cache_destroy(NULL);
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_KMEM_CACHE_DESTROY_INT, 1,
                [kmem_cache_destroy(cachep) return int])
],[
        AC_MSG_RESULT(NO)
])
])

# check cpumask_size (2.6.28)
AC_DEFUN([LIBCFS_CPUMASK_SIZE],
[AC_MSG_CHECKING([whether have cpumask_size()])
LB_LINUX_TRY_COMPILE([
	#include <linux/cpumask.h>
],[
	int size = cpumask_size();
],[
	AC_MSG_RESULT(yes)
	AC_DEFINE(HAVE_CPUMASK_SIZE, 1, [have cpumask_size()])
],[
	AC_MSG_RESULT(NO)
])
])

# check cpu topology functions
#
# topology_core_cpumask (2.6.29, not on all archs)
# topology_core_siblings (not on all archs)
# topology_thread_cpumask (2.6.29, not on all archs)
# topology_thread_siblings (not on all archs)
# cpumask_of_node/node_to_cpumask (not always exported)
AC_DEFUN([LIBCFS_CPU_TOPOLOGY],
[AC_MSG_CHECKING([whether have topology.h])
LB_LINUX_TRY_COMPILE([
	#include <linux/topology.h>
],[],[
	AC_DEFINE(HAVE_CPU_TOPOLOGY, 1, [have CPU topology])
	AC_MSG_RESULT(yes)

	AC_MSG_CHECKING([whether have topology_core_cpumask])
	LB_LINUX_TRY_COMPILE([
		#include <linux/topology.h>
	],[
		cpumask_t *mask = topology_core_cpumask(0);
	],[
		AC_DEFINE(HAVE_TOPOLOGY_CORE_CPUMASK, 1,
			  [have topology_core_cpumask])
		AC_MSG_RESULT(yes)
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([whether have topology_core_siblings])
	LB_LINUX_TRY_COMPILE([
		#include <linux/topology.h>
	],[
		cpumask_t mask = topology_core_siblings(0);
	],[
		AC_DEFINE(HAVE_TOPOLOGY_CORE_SIBLINGS, 1,
			  [have topology_core_siblings])
		AC_MSG_RESULT(yes)
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([whether have topology_thread_cpumask])
	LB_LINUX_TRY_COMPILE([
		#include <linux/topology.h>
	],[
		cpumask_t *mask = topology_thread_cpumask(0);
	],[
		AC_DEFINE(HAVE_TOPOLOGY_THREAD_CPUMASK, 1,
			  [have topology_thread_cpumask])
		AC_MSG_RESULT(yes)
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([whether have topology_thread_siblings])
	LB_LINUX_TRY_COMPILE([
		#include <linux/topology.h>
	],[
		cpumask_t mask = topology_thread_siblings(0);
	],[
		AC_DEFINE(HAVE_TOPOLOGY_THREAD_SIBLINGS, 1,
			  [have topology_thread_siblings])
		AC_MSG_RESULT(yes)
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([whether OFED backports have cpumask_of_node])
	# Some OFED has cpumask_of_node backports defined in
	# its private include/linux/cpumask.h. However, it is
	# defined conflictingly with kernel's cpumask_of_node.
	if test -f $OFED_BACKPORT_PATH/linux/cpumask.h; then
		grep -q cpumask_of_node $OFED_BACKPORT_PATH/linux/cpumask.h 2>/dev/null
		rc=$?
		if test $rc -eq 0; then
			AC_DEFINE(HAVE_OFED_CPUMASK_OF_NODE, 1, [have cpumask_of_node])
			AC_MSG_RESULT(yes)
		else
			AC_MSG_RESULT(no)
		fi
	fi

	AC_MSG_CHECKING([whether have cpumask_of_node])
	LB_LINUX_TRY_COMPILE([
		#include <linux/topology.h>
	],[
		cpumask_t *mask = cpumask_of_node(0);
	],[
		AC_DEFINE(HAVE_CPUMASK_OF_NODE, 1, [have cpumask_of_node])
		AC_MSG_RESULT(yes)
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([whether have cpumask_copy])
	LB_LINUX_TRY_COMPILE([
		#include <linux/cpumask.h>
	],[
		cpumask_copy(NULL, NULL);
	],[
		AC_DEFINE(HAVE_CPUMASK_COPY, 1, [have cpumask_copy])
		AC_MSG_RESULT(yes)
	],[
		AC_MSG_RESULT(no)
	])

	AC_MSG_CHECKING([whether have node_to_cpumask])
	LB_LINUX_TRY_COMPILE([
		#include <linux/topology.h>
	],[
		cpumask_t mask = node_to_cpumask(0);
	],[
		AC_DEFINE(HAVE_NODE_TO_CPUMASK, 1, [have node_to_cpumask])
		AC_MSG_RESULT(yes)
	],[
		AC_MSG_RESULT(no)
	])
],[
	AC_MSG_RESULT(NO)
])
])


# 2.6.20 API change INIT_WORK use 2 args and not
# store data inside
AC_DEFUN([LIBCFS_3ARGS_INIT_WORK],
[AC_MSG_CHECKING([check INIT_WORK want 3 args])
LB_LINUX_TRY_COMPILE([
	#include <linux/workqueue.h>
],[
	struct work_struct work __attribute__ ((unused));

	INIT_WORK(&work, NULL, NULL);
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_3ARGS_INIT_WORK, 1,
                  [INIT_WORK use 3 args and store data inside])
],[
        AC_MSG_RESULT(NO)
])
])

# 2.6.21 api change. 'register_sysctl_table' use only one argument,
# instead of more old which need two.
AC_DEFUN([LIBCFS_2ARGS_REGISTER_SYSCTL],
[AC_MSG_CHECKING([check register_sysctl_table want 2 args])
LB_LINUX_TRY_COMPILE([
        #include <linux/sysctl.h>
],[
	register_sysctl_table(NULL,0);
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_2ARGS_REGISTER_SYSCTL, 1,
                  [register_sysctl_table want 2 args])
],[
        AC_MSG_RESULT(NO)
])
])

# 2.6.23 lost dtor argument
AC_DEFUN([LIBCFS_KMEM_CACHE_CREATE_DTOR],
[AC_MSG_CHECKING([check kmem_cache_create has dtor argument])
LB_LINUX_TRY_COMPILE([
        #include <linux/slab.h>
],[
	kmem_cache_create(NULL, 0, 0, 0, NULL, NULL);
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_KMEM_CACHE_CREATE_DTOR, 1,
                  [kmem_cache_create has dtor argument])
],[
        AC_MSG_RESULT(NO)
])
])

#2.6.23 has new shrinker API
AC_DEFUN([LC_REGISTER_SHRINKER],
[AC_MSG_CHECKING([if kernel has register_shrinker])
LB_LINUX_TRY_COMPILE([
        #include <linux/mm.h>
],[
        register_shrinker(NULL);
], [
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_REGISTER_SHRINKER, 1,
                [kernel has register_shrinker])
],[
        AC_MSG_RESULT([no])
])
])

# 2.6.24 request not use real numbers for ctl_name
AC_DEFUN([LIBCFS_SYSCTL_UNNUMBERED],
[AC_MSG_CHECKING([for CTL_UNNUMBERED])
LB_LINUX_TRY_COMPILE([
        #include <linux/sysctl.h>
],[
	#ifndef CTL_UNNUMBERED
	#error CTL_UNNUMBERED not exist in kernel
	#endif
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_SYSCTL_UNNUMBERED, 1,
                  [sysctl has CTL_UNNUMBERED])
],[
        AC_MSG_RESULT(NO)
])
])

# 2.6.24 lost scatterlist->page
AC_DEFUN([LIBCFS_SCATTERLIST_SETPAGE],
[AC_MSG_CHECKING([for exist sg_set_page])
LB_LINUX_TRY_COMPILE([
        #include <asm/types.h>
        #include <linux/scatterlist.h>
],[
	sg_set_page(NULL,NULL,0,0);
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_SCATTERLIST_SETPAGE, 1,
                  [struct scatterlist has no page member])
],[
        AC_MSG_RESULT(NO)
])
])

# 2.6.24-rc1 sg_init_table
AC_DEFUN([LIBCFS_SCATTERLIST_INITTABLE],
[AC_MSG_CHECKING([for sg_init_table])
LB_LINUX_TRY_COMPILE([
	#include <asm/types.h>
	#include <linux/scatterlist.h>
],[
	sg_init_table(NULL,0);
],[
	AC_MSG_RESULT(yes)
	AC_DEFINE(HAVE_SCATTERLIST_INITTABLE, 1,
		  [scatterlist has sg_init_table])
],[
	AC_MSG_RESULT(NO)
])
])

# 2.6.24
AC_DEFUN([LIBCFS_NETWORK_NAMESPACE],
[AC_MSG_CHECKING([for network stack has namespaces])
LB_LINUX_TRY_COMPILE([
        #include <net/net_namespace.h>
],[
        struct net *net __attribute__ ((unused));
        net = &init_net;
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_INIT_NET, 1,
                  [kernel is support network namespaces ])
],[
        AC_MSG_RESULT(NO)
])
])

#
# LIBCFS_FUNC_DUMP_TRACE
#
# 2.6.23 exports dump_trace() so we can dump_stack() on any task
# 2.6.24 has stacktrace_ops.address with "reliable" parameter
#
AC_DEFUN([LIBCFS_FUNC_DUMP_TRACE],
[LB_CHECK_SYMBOL_EXPORT([dump_trace],
[kernel/ksyms.c arch/${LINUX_ARCH%_64}/kernel/traps_64.c arch/x86/kernel/dumpstack_32.c arch/x86/kernel/dumpstack_64.c],[
	tmp_flags="$EXTRA_KCFLAGS"
	EXTRA_KCFLAGS="-Werror"
	AC_MSG_CHECKING([whether we can really use dump_trace])
	LB_LINUX_TRY_COMPILE([
		struct task_struct;
		struct pt_regs;
		#include <asm/stacktrace.h>
	],[
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_DUMP_TRACE, 1, [dump_trace is exported])
	],[
		AC_MSG_RESULT(no)
	],[
	])
	AC_MSG_CHECKING([whether print_trace_address has reliable argument])
	LB_LINUX_TRY_COMPILE([
		struct task_struct;
		struct pt_regs;
		#include <asm/stacktrace.h>
	],[
		((struct stacktrace_ops *)0)->address(NULL, 0, 0);
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_TRACE_ADDRESS_RELIABLE, 1,
			  [print_trace_address has reliable argument])
	],[
		AC_MSG_RESULT(no)
	],[
	])
	AC_MSG_CHECKING([whether stacktrace_ops.warning is exist])
	LB_LINUX_TRY_COMPILE([
		struct task_struct;
		struct pt_regs;
		#include <asm/stacktrace.h>
	],[
		((struct stacktrace_ops *)0)->warning(NULL, NULL);
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_STACKTRACE_WARNING, 1, [stacktrace_ops.warning is exist])
	],[
		AC_MSG_RESULT(no)
	],[
	])
	AC_MSG_CHECKING([dump_trace want address])
	LB_LINUX_TRY_COMPILE([
		struct task_struct;
		struct pt_regs;
		#include <asm/stacktrace.h>
	],[
		dump_trace(NULL, NULL, NULL, 0, NULL, NULL);
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_DUMP_TRACE_ADDRESS, 1,
			  [dump_trace want address argument])
	],[
		AC_MSG_RESULT(no)
	],[
	])

EXTRA_KCFLAGS="$tmp_flags"
])
])


# 2.6.26 use int instead of atomic for sem.count
AC_DEFUN([LIBCFS_SEM_COUNT],
[AC_MSG_CHECKING([atomic sem.count])
LB_LINUX_TRY_COMPILE([
        #include <asm/semaphore.h>
],[
	struct semaphore s __attribute__ ((unused));

	atomic_read(&s.count);
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_SEM_COUNT_ATOMIC, 1,
                  [semaphore counter is atomic])
],[
        AC_MSG_RESULT(NO)
])
])

# 2.6.27 have second argument to sock_map_fd
AC_DEFUN([LIBCFS_SOCK_MAP_FD_2ARG],
[AC_MSG_CHECKING([sock_map_fd have second argument])
LB_LINUX_TRY_COMPILE([
	#include <linux/net.h>
],[
        sock_map_fd(NULL, 0);
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_SOCK_MAP_FD_2ARG, 1,
                  [sock_map_fd have second argument])
],[
        AC_MSG_RESULT(NO)
])
])

# LIBCFS_CRED_WRAPPERS
#
# wrappers for task's credentials are in sles11
#
AC_DEFUN([LIBCFS_CRED_WRAPPERS],
[AC_MSG_CHECKING([if kernel has wrappers for task's credentials])
LB_LINUX_TRY_COMPILE([
       #include <linux/sched.h>
],[
       uid_t uid;

       uid = current_uid() + sizeof(uid);
],[
       AC_MSG_RESULT([yes])
       AC_DEFINE(HAVE_CRED_WRAPPERS, 1, [task's cred wrappers found])
],[
       AC_MSG_RESULT([no])
])
])

#
# LN_STRUCT_CRED_IN_TASK
#
# struct cred was introduced in 2.6.29 to streamline credentials in task struct
#
AC_DEFUN([LIBCFS_STRUCT_CRED_IN_TASK],
[AC_MSG_CHECKING([if kernel has struct cred])
LB_LINUX_TRY_COMPILE([
       #include <linux/sched.h>
],[
       struct task_struct *tsk = NULL;
       tsk->real_cred = NULL;
],[
       AC_MSG_RESULT([yes])
       AC_DEFINE(HAVE_STRUCT_CRED, 1, [struct cred found])
],[
       AC_MSG_RESULT([no])
])
])

# LIBCFS_STRUCT_SHASH_ALG
# struct shash_alg was introduced in 2.6.29
#
AC_DEFUN([LIBCFS_STRUCT_SHASH_ALG],
[AC_MSG_CHECKING([if kernel has struct shash_alg])
LB_LINUX_TRY_COMPILE([
	#include <linux/err.h>
	#include <crypto/internal/hash.h>
],[
	struct shash_alg foo;
],[
	AC_MSG_RESULT([yes])
	AC_DEFINE(HAVE_STRUCT_SHASH_ALG, 1, [kernel has struct shash_alg])
],[
	AC_MSG_RESULT([no])
])
])


#
# LIBCFS_FUNC_UNSHARE_FS_STRUCT
#
# unshare_fs_struct was introduced in 2.6.30 to prevent others to directly
# mess with copy_fs_struct
#
AC_DEFUN([LIBCFS_FUNC_UNSHARE_FS_STRUCT],
[AC_MSG_CHECKING([if kernel defines unshare_fs_struct()])
tmp_flags="$EXTRA_KCFLAGS"
EXTRA_KCFLAGS="-Werror"
LB_LINUX_TRY_COMPILE([
       #include <linux/sched.h>
       #include <linux/fs_struct.h>
],[
       unshare_fs_struct();
],[
       AC_MSG_RESULT([yes])
       AC_DEFINE(HAVE_UNSHARE_FS_STRUCT, 1, [unshare_fs_struct found])
],[
       AC_MSG_RESULT([no])
])
EXTRA_KCFLAGS="$tmp_flags"
])

#
# LIBCFS_HAVE_IS_COMPAT_TASK
#
# Added in 2.6.17, it wasn't until 2.6.29 that all
# Linux architectures have is_compat_task()
#
AC_DEFUN([LIBCFS_HAVE_IS_COMPAT_TASK],
[AC_MSG_CHECKING([if is_compat_task() is declared])
LB_LINUX_TRY_COMPILE([
        #include <linux/compat.h>
],[
        int i __attribute__ ((unused));
        i = is_compat_task();
],[
        AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_IS_COMPAT_TASK, 1, [is_compat_task() is available])
],[
        AC_MSG_RESULT([no])
])
])

#
# LIBCFS_STACKTRACE_OPS_HAVE_WALK_STACK
#
# 2.6.32-30.el6 adds a new 'walk_stack' field in 'struct stacktrace_ops'
#
AC_DEFUN([LIBCFS_STACKTRACE_OPS_HAVE_WALK_STACK],
[AC_MSG_CHECKING([if 'struct stacktrace_ops' has 'walk_stack' field])
LB_LINUX_TRY_COMPILE([
        #include <asm/stacktrace.h>
],[
        ((struct stacktrace_ops *)0)->walk_stack(NULL, NULL, 0, NULL, NULL, NULL, NULL);
],[
        AC_MSG_RESULT([yes])
        AC_DEFINE(STACKTRACE_OPS_HAVE_WALK_STACK, 1, ['struct stacktrace_ops' has 'walk_stack' field])
],[
        AC_MSG_RESULT([no])
])
])

AC_DEFUN([LIBCFS_HAVE_OOM_H],
[LB_CHECK_FILE([$LINUX/include/linux/oom.h], [
        AC_DEFINE(HAVE_LINUX_OOM_H, 1,
                [kernel has include/oom.h])
],[
        AC_MSG_RESULT([no])
])
])

AC_DEFUN([LIBCFS_HAVE_KEYTYPE_H],
[LB_CHECK_FILE([$LINUX/include/linux/key-type.h], [
        AC_DEFINE(HAVE_LINUX_KEYTYPE_H, 1,
                [kernel has include/key-type.h])
],[
        AC_MSG_RESULT([no])
])
])

#
# check set_mems_allowed
# 2.6.31 adds function set_mems_allowed in cpuset.h
#
AC_DEFUN([LIBCFS_HAVE_SET_MEMS_ALLOWED],
[AC_MSG_CHECKING([whether have set_mems_allowed()])
LB_LINUX_TRY_COMPILE([
	#include <linux/cpuset.h>
],[
	nodemask_t mask;

	set_mems_allowed(mask);
],[
	AC_MSG_RESULT(yes)
	AC_DEFINE(HAVE_SET_MEMS_ALLOWED, 1, [have set_mems_allowed()])
],[
	AC_MSG_RESULT(NO)
])
])


#
# RHEL6/2.6.32 want to have pointer to shrinker self pointer in handler function
#
AC_DEFUN([LC_SHRINKER_WANT_SHRINK_PTR],
[AC_MSG_CHECKING([shrinker want self pointer in handler])
LB_LINUX_TRY_COMPILE([
        #include <linux/mm.h>
],[
        struct shrinker *tmp = NULL;
        tmp->shrink(tmp, 0, 0);
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_SHRINKER_WANT_SHRINK_PTR, 1,
                  [shrinker want self pointer in handler])
],[
        AC_MSG_RESULT(no)
])
])

# 2.6.18 store oom parameters in task struct.
# 2.6.32 store oom parameters in signal struct
AC_DEFUN([LIBCFS_OOMADJ_IN_SIG],
[AC_MSG_CHECKING([kernel store oom parameters in task])
LB_LINUX_TRY_COMPILE([
        #include <linux/sched.h>
],[
        ((struct signal_struct *)0)->oom_adj = 0;
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_OOMADJ_IN_SIG, 1,
                  [kernel store a oom parameters in signal struct])
],[
        AC_MSG_RESULT(no)
])
])

#
# 2.6.33 no longer has ctl_name & strategy field in struct ctl_table.
#
AC_DEFUN([LIBCFS_SYSCTL_CTLNAME],
[AC_MSG_CHECKING([if ctl_table has a ctl_name field])
LB_LINUX_TRY_COMPILE([
        #include <linux/sysctl.h>
],[
        struct ctl_table ct;
        ct.ctl_name = sizeof(ct);
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_SYSCTL_CTLNAME, 1,
                  [ctl_table has ctl_name field])
],[
        AC_MSG_RESULT(no)
])
])

#
# LIBCFS_ADD_WAIT_QUEUE_EXCLUSIVE
#
# 2.6.34 adds __add_wait_queue_exclusive
#
AC_DEFUN([LIBCFS_ADD_WAIT_QUEUE_EXCLUSIVE],
[AC_MSG_CHECKING([if __add_wait_queue_exclusive exists])
LB_LINUX_TRY_COMPILE([
        #include <linux/wait.h>
],[
        wait_queue_head_t queue;
        wait_queue_t      wait;

        __add_wait_queue_exclusive(&queue, &wait);
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE___ADD_WAIT_QUEUE_EXCLUSIVE, 1,
                  [__add_wait_queue_exclusive exists])
],[
        AC_MSG_RESULT(no)
])
])

#
# 2.6.35 kernel has sk_sleep function
#
AC_DEFUN([LC_SK_SLEEP],
[AC_MSG_CHECKING([if kernel has sk_sleep])
LB_LINUX_TRY_COMPILE([
        #include <net/sock.h>
],[
        sk_sleep(NULL);
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_SK_SLEEP, 1, [kernel has sk_sleep])
],[
        AC_MSG_RESULT(no)
])
])

#
# FC15 2.6.40-5 backported the "shrink_control" parameter to the memory
# pressure shrinker from Linux 3.0
#
AC_DEFUN([LC_SHRINK_CONTROL],
[AC_MSG_CHECKING([shrink_control is present])
LB_LINUX_TRY_COMPILE([
        #include <linux/mm.h>
],[
        struct shrink_control tmp = {0};
        tmp.nr_to_scan = sizeof(tmp);
],[
        AC_MSG_RESULT(yes)
        AC_DEFINE(HAVE_SHRINK_CONTROL, 1,
                  [shrink_control is present])
],[
        AC_MSG_RESULT(no)
])
])

#
# LIBCFS_PROG_LINUX
#
# LNet linux kernel checks
#
AC_DEFUN([LIBCFS_PROG_LINUX],
[
LIBCFS_CONFIG_PANIC_DUMPLOG

LIBCFS_U64_LONG_LONG_LINUX
# 2.6.18
LIBCFS_TASKLIST_LOCK
LIBCFS_HAVE_IS_COMPAT_TASK
LIBCFS_DIGEST_SETKEY_FLAGS
# 2.6.19
LIBCFS_KMEM_CACHE_DESTROY_INT
# 2.6.20
LIBCFS_3ARGS_INIT_WORK
# 2.6.21
LIBCFS_2ARGS_REGISTER_SYSCTL
# 2.6.23
LIBCFS_KMEM_CACHE_CREATE_DTOR
LC_REGISTER_SHRINKER
# 2.6.24
LIBCFS_SYSCTL_UNNUMBERED
LIBCFS_SCATTERLIST_SETPAGE
LIBCFS_SCATTERLIST_INITTABLE
LIBCFS_NETWORK_NAMESPACE
LIBCFS_FUNC_DUMP_TRACE
LIBCFS_HAVE_KEYTYPE_H
# 2.6.26
LIBCFS_SEM_COUNT
# 2.6.27
LIBCFS_CRED_WRAPPERS
# 2.6.28
LIBCFS_CPUMASK_SIZE
# 2.6.29
LIBCFS_STRUCT_CRED_IN_TASK
LIBCFS_CPU_TOPOLOGY
LIBCFS_STRUCT_SHASH_ALG
# 2.6.30
LIBCFS_FUNC_UNSHARE_FS_STRUCT
LIBCFS_SOCK_MAP_FD_2ARG
# 2.6.31
LIBCFS_HAVE_SET_MEMS_ALLOWED
# 2.6.32
LIBCFS_STACKTRACE_OPS_HAVE_WALK_STACK
LC_SHRINKER_WANT_SHRINK_PTR
LIBCFS_HAVE_OOM_H
LIBCFS_OOMADJ_IN_SIG
# 2.6.33
LIBCFS_SYSCTL_CTLNAME
# 2.6.34
LIBCFS_ADD_WAIT_QUEUE_EXCLUSIVE
# 2.6.35
LC_SK_SLEEP
# 2.6.40 fc15
LC_SHRINK_CONTROL
])

#
# LIBCFS_PROG_DARWIN
#
# Darwin checks
#
AC_DEFUN([LIBCFS_PROG_DARWIN],
[LB_DARWIN_CHECK_FUNCS([get_preemption_level])
])

#
# LIBCFS_PATH_DEFAULTS
#
# default paths for installed files
#
AC_DEFUN([LIBCFS_PATH_DEFAULTS],
[
])

#
# LIBCFS_CONFIGURE
#
# other configure checks
#
AC_DEFUN([LIBCFS_CONFIGURE],
[# lnet/utils/portals.c
AC_CHECK_HEADERS([asm/types.h endian.h sys/ioctl.h])

# lnet/utils/debug.c
AC_CHECK_HEADERS([linux/version.h])

AC_CHECK_TYPE([spinlock_t],
	[AC_DEFINE(HAVE_SPINLOCK_T, 1, [spinlock_t is defined])],
	[],
	[#include <linux/spinlock.h>])

# lnet/utils/wirecheck.c
AC_CHECK_FUNCS([strnlen])

# lnet/libcfs/user-prim.c, missing for RHEL5 and earlier userspace
AC_CHECK_FUNCS([strlcpy])

# libcfs/libcfs/user-prim.c, missing for RHEL5 and earlier userspace
AC_CHECK_FUNCS([strlcat])

AC_CHECK_TYPE([umode_t],
	[AC_DEFINE(HAVE_UMODE_T, 1, [umode_t is defined])],
	[],
	[#include <asm/types.h>])

AC_CHECK_TYPE([__s8],
	[AC_DEFINE(HAVE___S8, 1, [__s8 is defined])],
	[],
	[#include <asm/types.h>])

AC_CHECK_TYPE([__u8],
	[AC_DEFINE(HAVE___U8, 1, [__u8 is defined])],
	[],
	[#include <asm/types.h>])

AC_CHECK_TYPE([__s16],
	[AC_DEFINE(HAVE___S16, 1, [__s16 is defined])],
	[],
	[#include <asm/types.h>])

AC_CHECK_TYPE([__u16],
	[AC_DEFINE(HAVE___U16, 1, [__u16 is defined])],
	[],
	[#include <asm/types.h>])

AC_CHECK_TYPE([__s32],
	[AC_DEFINE(HAVE___S32, 1, [__s32 is defined])],
	[],
	[#include <asm/types.h>])

AC_CHECK_TYPE([__u32],
	[AC_DEFINE(HAVE___U32, 1, [__u32 is defined])],
	[],
	[#include <asm/types.h>])

AC_CHECK_TYPE([__u64],
	[AC_DEFINE(HAVE___U64, 1, [__u64 is defined])],
	[],
	[#include <asm/types.h>])

AC_CHECK_TYPE([__s64],
	[AC_DEFINE(HAVE___S64, 1, [__s64 is defined])],
	[],
	[#include <asm/types.h>])

# check userland __u64 type
AC_MSG_CHECKING([userspace __u64 is long long type])
tmp_flags="$CFLAGS"
CFLAGS="$CFLAGS -Werror"
AC_COMPILE_IFELSE([
	#include <stdio.h>
	#include <linux/types.h>
	#include <linux/stddef.h>
	int main(void) {
		unsigned long long *data1;
		__u64 *data2 = NULL;

		data1 = data2;
		data2 = data1;
		return 0;
	}
],[
	AC_MSG_RESULT([yes])
        AC_DEFINE(HAVE_USER__U64_LONG_LONG, 1,
                  [__u64 is long long type])
],[
	AC_MSG_RESULT([no])
])
CFLAGS="$tmp_flags"

# --------  Check for required packages  --------------


AC_MSG_CHECKING([if efence debugging support is requested])
AC_ARG_ENABLE(efence,
	AC_HELP_STRING([--enable-efence],
			[use efence library]),
	[],[enable_efence='no'])
AC_MSG_RESULT([$enable_efence])
if test "$enable_efence" = "yes" ; then
	LIBEFENCE="-lefence"
	AC_DEFINE(HAVE_LIBEFENCE, 1, [libefence support is requested])
else
	LIBEFENCE=""
fi
AC_SUBST(LIBEFENCE)


# -------- check for -lpthread support ----
AC_MSG_CHECKING([whether to use libpthread for libcfs library])
AC_ARG_ENABLE([libpthread],
       	AC_HELP_STRING([--disable-libpthread],
               	[disable libpthread]),
       	[],[enable_libpthread=yes])
if test "$enable_libpthread" = "yes" ; then
	AC_CHECK_LIB([pthread], [pthread_create],
		[ENABLE_LIBPTHREAD="yes"],
		[ENABLE_LIBPTHREAD="no"])
	if test "$ENABLE_LIBPTHREAD" = "yes" ; then
		AC_MSG_RESULT([$ENABLE_LIBPTHREAD])
		PTHREAD_LIBS="-lpthread"
		AC_DEFINE([HAVE_LIBPTHREAD], 1, [use libpthread])
	else
		PTHREAD_LIBS=""
		AC_MSG_RESULT([no libpthread is found])
	fi
	AC_SUBST(PTHREAD_LIBS)
else
	AC_MSG_RESULT([no (disabled explicitly)])
	ENABLE_LIBPTHREAD="no"
fi
AC_SUBST(ENABLE_LIBPTHREAD)


])

#
# LIBCFS_CONDITIONALS
#
# AM_CONDITOINAL defines for lnet
#
AC_DEFUN([LIBCFS_CONDITIONALS],
[
])

#
# LIBCFS_CONFIG_FILES
#
# files that should be generated with AC_OUTPUT
#
AC_DEFUN([LIBCFS_CONFIG_FILES],
[AC_CONFIG_FILES([
libcfs/Kernelenv
libcfs/Makefile
libcfs/autoMakefile
libcfs/autoconf/Makefile
libcfs/include/Makefile
libcfs/include/libcfs/Makefile
libcfs/include/libcfs/linux/Makefile
libcfs/include/libcfs/posix/Makefile
libcfs/include/libcfs/util/Makefile
libcfs/libcfs/Makefile
libcfs/libcfs/autoMakefile
libcfs/libcfs/linux/Makefile
libcfs/libcfs/posix/Makefile
libcfs/libcfs/util/Makefile
libcfs/include/libcfs/darwin/Makefile
libcfs/libcfs/darwin/Makefile
])
])

#
# LB_DARWIN_CHECK_FUNCS
#
# check for functions in the darwin kernel
# Note that this is broken for cross compiling
#
AC_DEFUN([LB_DARWIN_CHECK_FUNCS],
[AC_FOREACH([AC_Func], [$1],
  [AH_TEMPLATE(AS_TR_CPP(HAVE_[]AC_Func),
               [Define to 1 if you have the `]AC_Func[' function.])])dnl
for ac_func in $1
do
AC_MSG_CHECKING([for $1])
AS_IF([AC_TRY_COMMAND(nm /mach | grep "[$1]" >/dev/null 2>/dev/null)],[
	AC_MSG_RESULT([yes])
	AC_DEFINE_UNQUOTED(AS_TR_CPP([HAVE_$ac_func])) $2
],[
	AC_MSG_RESULT([no]) $3
])
done
])

#
# LB_DARWIN_CONDITIONALS
#
# AM_CONDITIONALs for darwin
#
AC_DEFUN([LB_DARWIN_CONDITIONALS],
[
])

#
# LB_PROG_DARWIN
#
# darwin tests
#
AC_DEFUN([LB_PROG_DARWIN],
[kernel_framework="/System/Library/Frameworks/Kernel.framework"
#
# FIXME: there should be a better way to get these than hard coding them
#
case $target_cpu in 
	powerpc*)
		EXTRA_KCFLAGS="$EXTRA_KCFLAGS -arch ppc -mtune=G4 -mlong-branch"
		EXTRA_KLDFLAGS="-arch ppc"
		;;
	i?86 | x86_64)
		EXTRA_KCFLAGS="$EXTRA_KCFLAGS -arch i386"
		EXTRA_KLDFLAGS="-arch i386"
		;;
esac

# Kernel of OS X is not 64bits(even in Tiger), but -m64 can be taken by gcc in Tiger
# (Tiger can support 64bits applications), so we have to eliminate -m64 while 
# building kextensions for and OS X.
CC=`echo $CC | sed -e "s/\-m64//g"`
EXTRA_KCFLAGS="$EXTRA_KCFLAGS -x c -pipe -Wno-trigraphs -fasm-blocks -g -O0"
EXTRA_KCFLAGS="$EXTRA_KCFLAGS -Wno-four-char-constants -Wmost -O0"
EXTRA_KCFLAGS="$EXTRA_KCFLAGS -fmessage-length=0"
EXTRA_KCFLAGS="$EXTRA_KCFLAGS -I$kernel_framework/Headers"
EXTRA_KCFLAGS="$EXTRA_KCFLAGS -I$kernel_framework/Headers/bsd"
EXTRA_KCFLAGS="$EXTRA_KCFLAGS -I$kernel_framework/PrivateHeaders"
EXTRA_KCFLAGS="$EXTRA_KCFLAGS -fno-common -nostdinc -fno-builtin"
EXTRA_KCFLAGS="$EXTRA_KCFLAGS -finline -fno-keep-inline-functions"
EXTRA_KCFLAGS="$EXTRA_KCFLAGS -force_cpusubtype_ALL -fno-exceptions"
EXTRA_KCFLAGS="$EXTRA_KCFLAGS -msoft-float -static"
EXTRA_KCFLAGS="$EXTRA_KCFLAGS -DKERNEL -DKERNEL_PRIVATE"
EXTRA_KCFLAGS="$EXTRA_KCFLAGS -DDRIVER_PRIVATE -DAPPLE -DNeXT"
EXTRA_KCFLAGS="$EXTRA_KCFLAGS -D__KERNEL__ -D__DARWIN__"
#
# C flags for Panther/Tiger
#
case $target_os in
        darwin8*)
                EXTRA_KCFLAGS="$EXTRA_KCFLAGS -D__DARWIN8__"
	;;
        darwin7*)
                EXTRA_KCFLAGS="$EXTRA_KCFLAGS -ffix-and-continue"
        ;;
esac

#
# Debugging flags. Remove!
#
EXTRA_KCFLAGS="$EXTRA_KCFLAGS -O0 -DMACH_ASSERT=1"
EXTRA_KLDFLAGS="$EXTRA_KLDFLAGS -static -nostdlib -r"
EXTRA_KLIBS="-lkmodc++ -lkmod -lcc_kext"
KMODEXT=""

AC_SUBST(EXTRA_KLDFLAGS)
AC_SUBST(EXTRA_KLIBS)

kextdir='/System/Library/Extensions/$(firstword $(macos_PROGRAMS)).kext'
plistdir='$(kextdir)/Contents'
macosdir='$(plistdir)/MacOS'

AC_SUBST(kextdir)
AC_SUBST(plistdir)
AC_SUBST(macosdir)

LN_PROG_DARWIN

LP_PROG_DARWIN

LC_PROG_DARWIN
])

#
# LB_PATH_LDISKFS
#
# --without-ldiskfs   - Disable ldiskfs support.
# --with-ldiskfs=no
#
# --with-ldiskfs      - Enable ldiskfs support and attempt to autodetect the
# --with-ldiskfs=yes    headers in one of the following places in this order:
#                       * ./ldiskfs
#                       * /usr/src/ldiskfs-*/$LINUXRELEASE
#                       * ../ldiskfs
#
# --with-ldiskfs=path - Enable ldiskfs support and use the headers in the
#                       provided path.  No autodetection is performed.
#
# --with-ldiskfs-obj  - When ldiskfs support is enabled the object directory
#                       will be based on the --with-ldiskfs directory.  If
#                       this is detected incorrectly it can be explicitly
#                       specified using this option.
#
# NOTE: As with all external packages ldiskfs is expected to already be
# configured and built.  However, if the ldiskfs tree is located in-tree
# (./ldiskfs) then it will be configured and built recursively as part of
# the lustre build system.
#
# NOTE: The lustre and in-tree ldiskfs build systems both make use these
# macros.  This is undesirable and confusing at best, it is potentially
# danagerous at worst.  The ldiskfs build system should be entirely stand
# alone without dependency on the lustre build system.
#
AC_DEFUN([LB_PATH_LDISKFS],
[
AC_ARG_WITH([ldiskfs],
	AC_HELP_STRING([--with-ldiskfs=path], [set path to ldiskfs source]),
	[],[
		if test x$enable_server = xyes && test x$enable_dist = xno; then
			with_ldiskfs='yes'
		else
			with_ldiskfs='no'
		fi
	])

case x$with_ldiskfs in
	xno)
		LDISKFS_DIR=
		;;
	xyes)
		LDISKFS_DIR=

		# Check ./ldiskfs
		ldiskfs_src=$PWD/ldiskfs
		if test -e "$ldiskfs_src"; then
			LDISKFS_DIR=$(readlink -f $ldiskfs_src)
		else
			# Check /usr/src/ldiskfs-*/$LINUXRELEASE
			ldiskfs_src=$(ls -1d \
				/usr/src/ldiskfs-*/$LINUXRELEASE \
				2>/dev/null | tail -1)
			if test -e "$ldiskfs_src"; then
				LDISKFS_DIR=$(readlink -f $ldiskfs_src)
			else
				# Check ../ldiskfs
				ldiskfs_src=$PWD/../ldiskfs
				if test -e "$ldiskfs_src"; then
					LDISKFS_DIR=$(readlink -f $ldiskfs_src)
				else
					# Disable ldiskfs failed to detect
					with_ldiskfs='no'
				fi
			fi
		fi

		;;
	*)
		LDISKFS_DIR=$(readlink -f $with_ldiskfs)
		with_ldiskfs='yes'
		;;
esac

AC_MSG_CHECKING([whether to enable ldiskfs])
AC_MSG_RESULT([$with_ldiskfs])

AC_ARG_WITH([ldiskfs-obj],
	AC_HELP_STRING([--with-ldiskfs-obj=path],[set path to ldiskfs objects]),
	[
		if test x$with_ldiskfs = xyes; then
			LDISKFS_OBJ="$withval"
		fi
	],[
		if test x$with_ldiskfs = xyes; then
			LDISKFS_OBJ=$LDISKFS_DIR
		fi
	])

if test x$with_ldiskfs = xyes; then
	AC_MSG_CHECKING([ldiskfs source directory])
	AC_MSG_RESULT([$LDISKFS_DIR])
	AC_SUBST(LDISKFS_DIR)

	AC_MSG_CHECKING([ldiskfs object directory])
	AC_MSG_RESULT([$LDISKFS_OBJ])
	AC_SUBST(LDISKFS_OBJ)

	LB_LDISKFS_SYMVERS
	LB_LDISKFS_EXT_DIR
	LB_LDISKFS_BUILD
	AC_DEFINE(HAVE_LDISKFS_OSD, 1, Enable ldiskfs osd)
fi

#
# LDISKFS_DEVEL is required because when using the ldiskfs-devel package the
# ext4 source will be fully patched to ldiskfs.  When building with the
# in-tree ldiskfs this patching this will occur after the configure step.
# We needed a way to determine if we should check the patched or unpatched
# source files.
#
# Longer term this could be removed by moving the ldiskfs patching in to
# the configure phase.  Or better yet ldiskfs could be updated to generate
# a ldiskfs_config.h which clearly defines how it was built.  This can
# then be directly included by Lustre to avoid all the autoconf guess work.
# For an example of this behavior consult the lustre/zfs build integration.
#
AM_CONDITIONAL(LDISKFS_DEVEL, \
	test x$LDISKFS_DIR = x$(readlink -f $PWD/ldiskfs) || \
	test x$LDISKFS_DIR = x$(readlink -f $PWD/../ldiskfs))

AM_CONDITIONAL(LDISKFS_BUILD, test x$enable_ldiskfs_build = xyes)
AM_CONDITIONAL(LDISKFS_ENABLED, test x$with_ldiskfs = xyes)

if test -e "$PWD/ldiskfs"; then
	LDISKFS_DIST_SUBDIR="ldiskfs"
	AC_SUBST(LDISKFS_DIST_SUBDIR)
	AC_CONFIG_SUBDIRS("ldiskfs")
fi
])

#
# LB_LDISKFS_EXT_DIR
#
# Determine the location of the ext4 source code.  It it required
# for several configure tests and to build ldiskfs.
#
AC_DEFUN([LB_LDISKFS_EXT_DIR],
[
# Kernel ext source located with devel headers
linux_src=$LINUX
if test -e "$linux_src/fs/ext4/super.c"; then
	EXT_DIR=$linux_src/fs/ext4
else
	# Kernel ext source provided by kernel-debuginfo-common package
	linux_src=$(ls -1d /usr/src/debug/*/linux-$LINUXRELEASE \
		2>/dev/null | tail -1)
	if test -e "$linux_src/fs/ext4/super.c"; then
		EXT_DIR=$linux_src/fs/ext4
	else
		EXT_DIR=
	fi
fi

AC_MSG_CHECKING([ext4 source directory])
AC_MSG_RESULT([$EXT_DIR])
AC_SUBST(EXT_DIR)
])

#
# LB_LDISKFS_EXT_SOURCE
#
# Spot check the existance of several source files common to ext4.
# Detecting this at configure time allows us to avoid a potential build
# failure and provide a useful error message to explain what is wrong.
#
AC_DEFUN([LB_LDISKFS_EXT_SOURCE],
[
if test x$EXT_DIR = x; then
	enable_ldiskfs_build='no'
else
	LB_CHECK_FILE([$EXT_DIR/dir.c], [], [
		enable_ldiskfs_build='no'
		AC_MSG_WARN([ext4 must exist for ldiskfs build])])
	LB_CHECK_FILE([$EXT_DIR/file.c], [], [
		enable_ldiskfs_build='no'
		AC_MSG_WARN([ext4 must exist for ldiskfs build])])
	LB_CHECK_FILE([$EXT_DIR/inode.c], [], [
		enable_ldiskfs_build='no'
		AC_MSG_WARN([ext4 must exist for ldiskfs build])])
	LB_CHECK_FILE([$EXT_DIR/super.c], [], [
		enable_ldiskfs_build='no'
		AC_MSG_WARN([ext4 must exist for ldiskfs build])])
fi

if test x$enable_ldiskfs_build = xno; then
	enable_ldiskfs_build='no'
	with_ldiskfs='no'
	LDISKFS_SUBDIR=

	AC_MSG_WARN([

Disabling server because complete ext4 source does not exist.

If you are building using kernel-devel packages and require ldiskfs
server support then ensure that the matching kernel-debuginfo-common
and kernel-debuginfo-common-<arch> packages are installed.

])

fi
])

#
# Optionally configure/make the ldiskfs sources.  If the sources are
# determined to reside in-tree this feature will automatically be
# enabled.  If the sources are not in-tree it will be disabled.
# Use --enable-ldiskfs-build or --disable-ldiskfs-build if you need
# to override this behavior.
#
AC_DEFUN([LB_LDISKFS_BUILD],
[
AC_ARG_ENABLE([ldiskfs-build],
	AC_HELP_STRING([--enable-ldiskfs-build],
		[enable ldiskfs configure/make]),
	[], [
		LDISKFS_DIR_INTREE=$(readlink -f $PWD/ldiskfs)
		if test x$LDISKFS_DIR = x$LDISKFS_DIR_INTREE; then
			enable_ldiskfs_build='yes'
		else
			enable_ldiskfs_build='no'
		fi
	])

AC_MSG_CHECKING([whether to build ldiskfs])
if test x$enable_ldiskfs_build = xyes; then
	AC_MSG_RESULT([$enable_ldiskfs_build])
	LDISKFS_SUBDIR="ldiskfs"

	LB_CHECK_FILE([$LDISKFS_DIR/configure], [], [
		AC_MSG_ERROR([Complete ldiskfs build system must exist])])
	LB_LDISKFS_EXT_SOURCE

	AC_SUBST(LDISKFS_SUBDIR)
else
	enable_ldiskfs_build='no'
	AC_MSG_RESULT([$enable_ldiskfs_build])
fi
])

AC_DEFUN([LB_LDISKFS_SYMVERS],
[
AC_MSG_CHECKING([ldiskfs module symbols])
if test -r $LDISKFS_OBJ/Module.symvers; then
	LDISKFS_SYMBOLS=Module.symvers
elif test -r $LDISKFS_OBJ/Modules.symvers; then
	LDISKFS_SYMBOLS=Modules.symvers
elif test -r $LDISKFS_OBJ/ldiskfs/Module.symvers; then
	LDISKFS_SYMBOLS=Module.symvers
elif test -r $LDISKFS_OBJ/ldiskfs/Modules.symvers; then
	LDISKFS_SYMBOLS=Modules.symvers
else
	LDISKFS_SYMBOLS=$SYMVERFILE
fi

AC_MSG_RESULT([$LDISKFS_SYMBOLS])
AC_SUBST(LDISKFS_SYMBOLS)
])

#
# LB_DEFINE_E2FSPROGS_NAMES
#
# Enable the use of alternate naming of ldiskfs-enabled e2fsprogs package.
#
AC_DEFUN([LB_DEFINE_E2FSPROGS_NAMES],
[
AC_ARG_WITH([ldiskfsprogs],
        AC_HELP_STRING([--with-ldiskfsprogs],
                       [use alternate names for ldiskfs-enabled e2fsprogs]),
	[],[withval='no'])

AC_MSG_CHECKING([whether to use alternate names for e2fsprogs])
if test x$withval = xyes ; then
	AC_DEFINE(HAVE_LDISKFSPROGS, 1, [enable use of ldiskfsprogs package])
	E2FSPROGS="ldiskfsprogs"
	MKE2FS="mkfs.ldiskfs"
	DEBUGFS="debugfs.ldiskfs"
	TUNE2FS="tunefs.ldiskfs"
	E2LABEL="label.ldiskfs"
	DUMPE2FS="dumpfs.ldiskfs"
	E2FSCK="fsck.ldiskfs"
	PFSCK="pfsck.ldiskfs"
	AC_MSG_RESULT([enabled])
else
	E2FSPROGS="e2fsprogs"
	MKE2FS="mke2fs"
	DEBUGFS="debugfs"
	TUNE2FS="tune2fs"
	E2LABEL="e2label"
	DUMPE2FS="dumpe2fs"
	E2FSCK="e2fsck"
	PFSCK="fsck"
	AC_MSG_RESULT([disabled])
fi

AC_DEFINE_UNQUOTED(E2FSPROGS, "$E2FSPROGS", [name of ldiskfs e2fsprogs package])
AC_DEFINE_UNQUOTED(MKE2FS, "$MKE2FS", [name of ldiskfs mkfs program])
AC_DEFINE_UNQUOTED(DEBUGFS, "$DEBUGFS", [name of ldiskfs debug program])
AC_DEFINE_UNQUOTED(TUNE2FS, "$TUNE2FS", [name of ldiskfs tune program])
AC_DEFINE_UNQUOTED(E2LABEL, "$E2LABEL", [name of ldiskfs label program])
AC_DEFINE_UNQUOTED(DUMPE2FS,"$DUMPE2FS", [name of ldiskfs dump program])
AC_DEFINE_UNQUOTED(E2FSCK, "$E2FSCK", [name of ldiskfs fsck program])
AC_DEFINE_UNQUOTED(PFSCK, "$PFSCK", [name of parallel fsck program])

AC_SUBST([E2FSPROGS], [$E2FSPROGS])
AC_SUBST([MKE2FS], [$MKE2FS])
AC_SUBST([DEBUGFS], [$DEBUGFS])
AC_SUBST([TUNE2FS], [$TUNE2FS])
AC_SUBST([E2LABEL], [$E2LABEL])
AC_SUBST([DUMPE2FS], [$DUMPE2FS])
AC_SUBST([E2FSCK], [$E2FSCK])
AC_SUBST([PFSCK], [$PFSCK])
])

#
# LB_LINUX_VERSION
#
# Set things accordingly for a linux kernel
#
AC_DEFUN([LB_LINUX_VERSION],[
KMODEXT=".ko"

MODULE_TARGET="SUBDIRS"
makerule="$PWD/build"
AC_MSG_CHECKING([for external module build support])
rm -f build/conftest.i
LB_LINUX_TRY_MAKE([],[],
	[$makerule LUSTRE_KERNEL_TEST=conftest.i],
	[test -s build/conftest.i],
	[
		AC_MSG_RESULT([no])
	],[
		makerule="_module_$makerule"
		MODULE_TARGET="M"
		LB_LINUX_TRY_MAKE([],[],
			[$makerule LUSTRE_KERNEL_TEST=conftest.i],
			[test -s build/conftest.i],
			[
				AC_MSG_RESULT([yes])
			],[
				AC_MSG_ERROR([unknown; check config.log for details])
			])
	])

AC_SUBST(MODULE_TARGET)
AC_SUBST(KMODEXT)
])

#
# LB_LINUX_RELEASE
#
# get the release version of linux
#
AC_DEFUN([LB_LINUX_RELEASE],
[LINUXRELEASE=
rm -f build/conftest.i
AC_MSG_CHECKING([for Linux release])
if test -s $LINUX_OBJ/include/$AUTOCONF_HDIR/utsrelease.h ; then
	LINUXRELEASEHEADER=$AUTOCONF_HDIR/utsrelease.h
else
	LINUXRELEASEHEADER=linux/version.h
fi
LB_LINUX_TRY_MAKE([
	#include <$LINUXRELEASEHEADER>
],[
	char *LINUXRELEASE;
	LINUXRELEASE=UTS_RELEASE;
],[
	$makerule LUSTRE_KERNEL_TEST=conftest.i
],[
	test -s build/conftest.i
],[
	# LINUXRELEASE="UTS_RELEASE"
	eval $(grep "LINUXRELEASE=" build/conftest.i)
],[
	AC_MSG_RESULT([unknown])
	AC_MSG_ERROR([Could not preprocess test program.  Consult config.log for details.])
])
rm -f build/conftest.i
if test x$LINUXRELEASE = x ; then
	AC_MSG_RESULT([unknown])
	AC_MSG_ERROR([Could not determine Linux release version from linux/version.h.])
fi
AC_MSG_RESULT([$LINUXRELEASE])
AC_SUBST(LINUXRELEASE)

moduledir='$(CROSS_PATH)/lib/modules/$(LINUXRELEASE)/updates/kernel'
AC_SUBST(moduledir)

modulefsdir='$(moduledir)/fs/$(PACKAGE)'
AC_SUBST(modulefsdir)

modulenetdir='$(moduledir)/net/$(PACKAGE)'
AC_SUBST(modulenetdir)

# ------------ RELEASE --------------------------------
AC_MSG_CHECKING([for Lustre release])
AC_ARG_WITH([release],
	AC_HELP_STRING([--with-release=string],
		       [set the release string (default=$kvers_YYYYMMDDhhmm)]),
	[RELEASE=$withval],
	RELEASE=""
	if test -n "$DOWNSTREAM_RELEASE"; then
		RELEASE="${DOWNSTREAM_RELEASE}_"
	fi
	RELEASE="$RELEASE`echo ${LINUXRELEASE} | tr '-' '_'`_$BUILDID")
AC_MSG_RESULT($RELEASE)
AC_SUBST(RELEASE)

# check is redhat/suse kernels
AC_MSG_CHECKING([that RedHat kernel])
LB_LINUX_TRY_COMPILE([
		#include <linux/version.h>
	],[
		#ifndef RHEL_RELEASE_CODE
		#error "not redhat kernel"
		#endif
	],[
		RHEL_KERNEL="yes"
		AC_MSG_RESULT([yes])
	],[
	        AC_MSG_RESULT([no])
])

LB_LINUX_CONFIG([SUSE_KERNEL],[SUSE_KERNEL="yes"],[])

])

# LB_ARG_REPLACE_PATH(PACKAGE, PATH)
AC_DEFUN([LB_ARG_REPLACE_PATH],[
	new_configure_args=
	eval "set x $ac_configure_args"
	shift
	for arg; do
		case $arg in
			--with-[$1]=*)
				arg=--with-[$1]=[$2]
				;;
			*\'*)
				arg=$(printf %s\n ["$arg"] | \
				      sed "s/'/'\\\\\\\\''/g")
				;;
		esac
		dnl AS_VAR_APPEND([new_configure_args], [" '$arg'"])
		new_configure_args="$new_configure_args \"$arg\""
	done
	ac_configure_args=$new_configure_args
])

# this is the work-horse of the next function
AC_DEFUN([__LB_ARG_CANON_PATH], [
	[$3]=$(readlink -f $with_$2)
	LB_ARG_REPLACE_PATH([$1], $[$3])
])

# a front-end for the above function that transforms - and . in the
# PACKAGE portion of --with-PACKAGE into _ suitable for variable names
AC_DEFUN([LB_ARG_CANON_PATH], [
	__LB_ARG_CANON_PATH([$1], m4_translit([$1], [-.], [__]), [$2])
])

#
#
# LB_LINUX_PATH
#
# Find paths for linux, handling kernel-source rpms
#
AC_DEFUN([LB_LINUX_PATH],
[# prep some default values
for DEFAULT_LINUX in /lib/modules/$(uname -r)/{source,build} /usr/src/linux; do
	if readlink -q -e $DEFAULT_LINUX; then
		break
	fi
done
if test "$DEFAULT_LINUX" = "/lib/modules/$(uname -r)/source"; then
	PATHS="/lib/modules/$(uname -r)/build"
fi
PATHS+=" $DEFAULT_LINUX"
for DEFAULT_LINUX_OBJ in $PATHS; do
	if readlink -q -e $DEFAULT_LINUX_OBJ; then
		break
	fi
done
AC_MSG_CHECKING([for Linux sources])
AC_ARG_WITH([linux],
	AC_HELP_STRING([--with-linux=path],
		       [set path to Linux source (default=/lib/modules/$(uname -r)/{source,build},/usr/src/linux)]),
	[LB_ARG_CANON_PATH([linux], [LINUX])
	DEFAULT_LINUX_OBJ=$LINUX],
	[LINUX=$DEFAULT_LINUX])
AC_MSG_RESULT([$LINUX])
AC_SUBST(LINUX)

# -------- check for linux --------
LB_CHECK_FILE([$LINUX],[],
	[AC_MSG_ERROR([Kernel source $LINUX could not be found.])])

# -------- linux objects (for 2.6) --
AC_MSG_CHECKING([for Linux objects dir])
AC_ARG_WITH([linux-obj],
	AC_HELP_STRING([--with-linux-obj=path],
			[set path to Linux objects dir (default=/lib/modules/$(uname -r)/build,/usr/src/linux)]),
	[LB_ARG_CANON_PATH([linux-obj], [LINUX_OBJ])],
	[LINUX_OBJ=$DEFAULT_LINUX_OBJ])

AC_MSG_RESULT([$LINUX_OBJ])
AC_SUBST(LINUX_OBJ)

# -------- check for .config --------
AC_ARG_WITH([linux-config],
	[AC_HELP_STRING([--with-linux-config=path],
			[set path to Linux .conf (default=$LINUX_OBJ/.config)])],
	[LB_ARG_CANON_PATH([linux-config], [LINUX_CONFIG])],
	[LINUX_CONFIG=$LINUX_OBJ/.config])
AC_SUBST(LINUX_CONFIG)

LB_CHECK_FILE([/boot/kernel.h],
	[KERNEL_SOURCE_HEADER='/boot/kernel.h'],
	[LB_CHECK_FILE([/var/adm/running-kernel.h],
		[KERNEL_SOURCE_HEADER='/var/adm/running-kernel.h'])])

AC_ARG_WITH([kernel-source-header],
	AC_HELP_STRING([--with-kernel-source-header=path],
			[Use a different kernel version header.  Consult build/README.kernel-source for details.]),
	[LB_ARG_CANON_PATH([kernel-source-header], [KERNEL_SOURCE_HEADER])])

# ------------ .config exists ----------------
LB_CHECK_FILE([$LINUX_CONFIG],[],
	[AC_MSG_ERROR([Kernel config could not be found.  If you are building from a kernel-source rpm consult build/README.kernel-source])])

# ----------- make dep run? ------------------
# at 2.6.19 # $LINUX/include/linux/config.h is removed
# and at more old has only one line
# include <autoconf.h>
LB_CHECK_FILE([$LINUX_OBJ/include/generated/autoconf.h],[AUTOCONF_HDIR=generated],
        [LB_CHECK_FILE([$LINUX_OBJ/include/linux/autoconf.h],[AUTOCONF_HDIR=linux],
	[AC_MSG_ERROR([Run make config in $LINUX.])])])
        AC_SUBST(AUTOCONF_HDIR)
LB_CHECK_FILE([$LINUX_OBJ/include/linux/version.h],[],
	[AC_MSG_ERROR([Run make config in $LINUX.])])

# ----------- kconfig.h exists ---------------
# kernel 3.1, $LINUX/include/linux/kconfig.h is added
# see kernel commit 2a11c8ea20bf850b3a2c60db8c2e7497d28aba99
LB_CHECK_FILE([$LINUX_OBJ/include/linux/kconfig.h],
              [CONFIG_INCLUDE=include/linux/kconfig.h],
              [CONFIG_INCLUDE=include/$AUTOCONF_HDIR/autoconf.h])
	AC_SUBST(CONFIG_INCLUDE)

# ------------ rhconfig.h includes runtime-generated bits --
# red hat kernel-source checks

# we know this exists after the check above.  if the user
# tarred up the tree and ran make dep etc. in it, then
# version.h gets overwritten with a standard linux one.

if grep rhconfig $LINUX_OBJ/include/linux/version.h >/dev/null ; then
	# This is a clean kernel-source tree, we need to
	# enable extensive workarounds to get this to build
	# modules
	LB_CHECK_FILE([$KERNEL_SOURCE_HEADER],
		[if test $KERNEL_SOURCE_HEADER = '/boot/kernel.h' ; then
			AC_MSG_WARN([Using /boot/kernel.h from RUNNING kernel.])
			AC_MSG_WARN([If this is not what you want, use --with-kernel-source-header.])
			AC_MSG_WARN([Consult build/README.kernel-source for details.])
		fi],
		[AC_MSG_ERROR([$KERNEL_SOURCE_HEADER not found.  Consult build/README.kernel-source for details.])])
	EXTRA_KCFLAGS="-include $KERNEL_SOURCE_HEADER $EXTRA_KCFLAGS"
fi

# this is needed before we can build modules
LB_LINUX_CROSS
LB_LINUX_VERSION

# --- check that we can build modules at all
AC_MSG_CHECKING([that modules can be built at all])
LB_LINUX_TRY_COMPILE([],[],[
	AC_MSG_RESULT([yes])
],[
	AC_MSG_RESULT([no])
	AC_MSG_WARN([Consult config.log for details.])
	AC_MSG_WARN([If you are trying to build with a kernel-source rpm, consult build/README.kernel-source])
	AC_MSG_ERROR([Kernel modules cannot be built.])
])

LB_LINUX_RELEASE
]) # end of LB_LINUX_PATH

# LB_LINUX_SYMVERFILE
# SLES 9 uses a different name for this file - unsure about vanilla kernels
# around this version, but it matters for servers only.
AC_DEFUN([LB_LINUX_SYMVERFILE],
	[AC_MSG_CHECKING([name of module symbol version file])
	if grep -q Modules.symvers $LINUX/scripts/Makefile.modpost ; then
		SYMVERFILE=Modules.symvers
	else
		SYMVERFILE=Module.symvers
	fi
	AC_MSG_RESULT($SYMVERFILE)
	AC_SUBST(SYMVERFILE)
])

#
# LB_LINUX_CROSS
#
# check for cross compilation
#
AC_DEFUN([LB_LINUX_CROSS],
	[AC_MSG_CHECKING([for cross compilation])
CROSS_VARS=
CROSS_PATH=
case $target_vendor in
	# The K1OM architecture is an extension of the x86 architecture.
	# So, the $target_arch is x86_64.
	k1om)
		AC_MSG_RESULT([Intel(R) Xeon Phi(TM)])
		CC_TARGET_ARCH=`$CC -v 2>&1 | grep Target: | sed -e 's/Target: //'`
		if test $CC_TARGET_ARCH != x86_64-$target_vendor-linux ; then
			AC_MSG_ERROR([Cross compiler not found in PATH.])
		fi
		CROSS_VARS="ARCH=$target_vendor CROSS_COMPILE=x86_64-$target_vendor-linux-"
		CROSS_PATH=${CROSS_PATH:=/opt/intel/mic/lustre/device-k1om}
		CCAS=$CC
		# need to produce special section for debuginfo extraction
		LDFLAGS="${LDFLAGS} -Wl,--build-id"
		EXTRA_KLDFLAGS="${EXTRA_KLDFLAGS} -Wl,--build-id"
		if test x$enable_server = xyes ; then
			AC_MSG_WARN([Disabling server (not supported for x86_64-$target_vendor-linux).])
			enable_server='no'
		fi
		;;
	*)
		AC_MSG_RESULT([no])
		;;
esac
AC_SUBST(CROSS_VARS)
AC_SUBST(CROSS_PATH)
])

# these are like AC_TRY_COMPILE, but try to build modules against the
# kernel, inside the build directory

# LB_LANG_PROGRAM(C)([PROLOGUE], [BODY])
# --------------------------------------
m4_define([LB_LANG_PROGRAM],
[
#include <linux/kernel.h>
$1
int
main (void)
{
dnl Do *not* indent the following line: there may be CPP directives.
dnl Don't move the `;' right after for the same reason.
$2
  ;
  return 0;
}])

#
# LB_LINUX_COMPILE_IFELSE
#
# like AC_COMPILE_IFELSE
#
AC_DEFUN([LB_LINUX_COMPILE_IFELSE],
[m4_ifvaln([$1], [AC_LANG_CONFTEST([$1])])dnl
rm -f build/conftest.o build/conftest.mod.c build/conftest.ko
AS_IF([AC_TRY_COMMAND(cp conftest.c build && make -d [$2] ${LD:+"LD=$LD"} CC="$CC" -f $PWD/build/Makefile LUSTRE_LINUX_CONFIG=$LINUX_CONFIG LINUXINCLUDE="$EXTRA_LNET_INCLUDE -I$LINUX/arch/`echo $target_cpu|sed -e 's/powerpc64/powerpc/' -e 's/x86_64/x86/' -e 's/i.86/x86/'`/include -I$LINUX/arch/`echo $target_cpu|sed -e 's/ppc.*/powerpc/' -e 's/x86_64/x86/' -e 's/i.86/x86/'`/include/generated -I$LINUX_OBJ/include -I$LINUX/include -I$LINUX_OBJ/include2 -include $CONFIG_INCLUDE" -o tmp_include_depends -o scripts -o include/config/MARKER -C $LINUX_OBJ EXTRA_CFLAGS="-Werror-implicit-function-declaration $EXTRA_KCFLAGS" $CROSS_VARS $MODULE_TARGET=$PWD/build) >/dev/null && AC_TRY_COMMAND([$3])],
	[$4],
	[_AC_MSG_LOG_CONFTEST
m4_ifvaln([$5],[$5])dnl])
rm -f build/conftest.o build/conftest.mod.c build/conftest.mod.o build/conftest.ko m4_ifval([$1], [build/conftest.c conftest.c])[]dnl
])

#
# LB_LINUX_ARCH
#
# Determine the kernel's idea of the current architecture
#
AC_DEFUN([LB_LINUX_ARCH],
         [AC_MSG_CHECKING([Linux kernel architecture])
          AS_IF([rm -f $PWD/build/arch
                 make -s --no-print-directory echoarch -f $PWD/build/Makefile \
                     LUSTRE_LINUX_CONFIG=$LINUX_CONFIG -C $LINUX $CROSS_VARS  \
                     ARCHFILE=$PWD/build/arch && LINUX_ARCH=`cat $PWD/build/arch`],
                [AC_MSG_RESULT([$LINUX_ARCH])],
                [AC_MSG_ERROR([Could not determine the kernel architecture.])])
          rm -f build/arch])

#
# LB_LINUX_TRY_COMPILE
#
# like AC_TRY_COMPILE
#
AC_DEFUN([LB_LINUX_TRY_COMPILE],
[LB_LINUX_COMPILE_IFELSE(
	[AC_LANG_SOURCE([LB_LANG_PROGRAM([[$1]], [[$2]])])],
	[modules],
	[test -s build/conftest.o],
	[$3], [$4])])

#
# LB_LINUX_CONFIG
#
# check if a given config option is defined
#
AC_DEFUN([LB_LINUX_CONFIG],[
	AC_MSG_CHECKING([if Linux was built with CONFIG_$1])
	LB_LINUX_TRY_COMPILE([
		#include <$AUTOCONF_HDIR/autoconf.h>
	],[
		#ifndef CONFIG_$1
		#error CONFIG_$1 not #defined
		#endif
	],[
		AC_MSG_RESULT([yes])
		$2
	],[
		AC_MSG_RESULT([no])
		$3
	])
])

#
# LB_LINUX_CONFIG_IM
#
# check if a given config option is builtin or as module
#
AC_DEFUN([LB_LINUX_CONFIG_IM],[
	AC_MSG_CHECKING([if Linux was built with CONFIG_$1 in or as module])
	LB_LINUX_TRY_COMPILE([
		#include <$AUTOCONF_HDIR/autoconf.h>
	],[
		#if !(defined(CONFIG_$1) || defined(CONFIG_$1_MODULE))
		#error CONFIG_$1 and CONFIG_$1_MODULE not #defined
		#endif
	],[
		AC_MSG_RESULT([yes])
		$2
	],[
		AC_MSG_RESULT([no])
		$3
	])
])

#
# LB_LINUX_TRY_MAKE
#
# like LB_LINUX_TRY_COMPILE, but with different arguments
#
AC_DEFUN([LB_LINUX_TRY_MAKE],
	[LB_LINUX_COMPILE_IFELSE(
		[AC_LANG_SOURCE([LB_LANG_PROGRAM([[$1]], [[$2]])])],
		[$3], [$4], [$5], [$6]
	)]
)

#
# LB_CONFIG_COMPAT_RDMA
#
AC_DEFUN([LB_CONFIG_COMPAT_RDMA],
[AC_MSG_CHECKING([whether to use Compat RDMA])
# set default
AC_ARG_WITH([o2ib],
	AC_HELP_STRING([--with-o2ib=path],
		       [build o2iblnd against path]),
	[
		case $with_o2ib in
		yes)    O2IBPATHS="$LINUX $LINUX/drivers/infiniband"
			ENABLEO2IB=2
			;;
		no)     ENABLEO2IB=0
			;;
		*)      O2IBPATHS=$with_o2ib
			ENABLEO2IB=3
			;;
		esac
	],[
		O2IBPATHS="$LINUX $LINUX/drivers/infiniband"
		ENABLEO2IB=1
	])
if test $ENABLEO2IB -eq 0; then
	AC_MSG_RESULT([no])
else
	o2ib_found=false
	for O2IBPATH in $O2IBPATHS; do
		if test \( -f ${O2IBPATH}/include/rdma/rdma_cm.h -a \
			   -f ${O2IBPATH}/include/rdma/ib_cm.h -a \
			   -f ${O2IBPATH}/include/rdma/ib_verbs.h -a \
			   -f ${O2IBPATH}/include/rdma/ib_fmr_pool.h \); then
			o2ib_found=true
			break
		fi
	done
	compatrdma_found=false
	if $o2ib_found; then
		if test \( -f ${O2IBPATH}/include/linux/compat-2.6.h \); then
			compatrdma_found=true
			AC_MSG_RESULT([yes])
			AC_DEFINE(HAVE_COMPAT_RDMA, 1, [compat rdma found])
		else
			AC_MSG_RESULT([no])
		fi
	fi
fi
])

#
# LB_CONFIG_OFED_BACKPORTS
#
# include any OFED backport headers in all compile commands
# NOTE: this does only include the backport paths, not the OFED headers
#       adding the OFED headers is done in the lnet portion
AC_DEFUN([LB_CONFIG_OFED_BACKPORTS],
[AC_MSG_CHECKING([whether to use any OFED backport headers])
if test $ENABLEO2IB -eq 0; then
	AC_MSG_RESULT([no])
else
	if ! $o2ib_found; then
		AC_MSG_RESULT([no])
		case $ENABLEO2IB in
			1) ;;
			2) AC_MSG_ERROR([kernel OpenIB gen2 headers not present]);;
			3) AC_MSG_ERROR([bad --with-o2ib path]);;
			*) AC_MSG_ERROR([internal error]);;
		esac
	else
		if ! $compatrdma_found; then
                	if test -f $O2IBPATH/config.mk; then
				. $O2IBPATH/config.mk
			elif test -f $O2IBPATH/ofed_patch.mk; then
				. $O2IBPATH/ofed_patch.mk
			fi
		fi
		if test -n "$BACKPORT_INCLUDES"; then
			OFED_BACKPORT_PATH="$O2IBPATH/${BACKPORT_INCLUDES/*\/kernel_addons/kernel_addons}/"
			EXTRA_LNET_INCLUDE="-I$OFED_BACKPORT_PATH $EXTRA_LNET_INCLUDE"
			AC_MSG_RESULT([yes])
		else
			AC_MSG_RESULT([no])
		fi
	fi
fi
])

# LC_MODULE_LOADING
# after 2.6.28 CONFIG_KMOD is removed, and only CONFIG_MODULES remains
# so we test if request_module is implemented or not
AC_DEFUN([LC_MODULE_LOADING],
[AC_MSG_CHECKING([if kernel module loading is possible])
LB_LINUX_TRY_MAKE([
	#include <linux/kmod.h>
],[
	int myretval=ENOSYS ;
	return myretval;
],[
	$makerule LUSTRE_KERNEL_TEST=conftest.i
],[dnl
	grep request_module build/conftest.i |dnl
		grep -v `grep "int myretval=" build/conftest.i |dnl
			cut -d= -f2 | cut -d" "  -f1`dnl
		>/dev/null dnl
],[
	AC_MSG_RESULT(yes)
	AC_DEFINE(HAVE_MODULE_LOADING_SUPPORT, 1,
		  [kernel module loading is possible])
],[
	AC_MSG_RESULT(no)
	AC_MSG_WARN([])
	AC_MSG_WARN([Kernel module loading support is highly recommended.])
	AC_MSG_WARN([])
])
])

#
# LB_PROG_LINUX
#
# linux tests
#
AC_DEFUN([LB_PROG_LINUX],
[LB_LINUX_PATH
LB_LINUX_ARCH
LB_LINUX_SYMVERFILE


LB_LINUX_CONFIG([MODULES],[],[
	AC_MSG_ERROR([module support is required to build Lustre kernel modules.])
])

LB_LINUX_CONFIG([MODVERSIONS])

LB_LINUX_CONFIG([KALLSYMS],[],[
	AC_MSG_ERROR([Lustre requires that CONFIG_KALLSYMS is enabled in your kernel.])
])

# 2.6.28
LC_MODULE_LOADING

LB_CONFIG_COMPAT_RDMA

# it's ugly to be doing anything with OFED outside of the lnet module, but
# this has to be done here so that the backports path is set before all of
# the LN_PROG_LINUX checks are done
LB_CONFIG_OFED_BACKPORTS
])

#
# LB_CHECK_SYMBOL_EXPORT
# check symbol exported or not
# $1 - symbol
# $2 - file(s) for find.
# $3 - do 'yes'
# $4 - do 'no'
#
# 2.6 based kernels - put modversion info into $LINUX/Module.modvers
# or check
AC_DEFUN([LB_CHECK_SYMBOL_EXPORT],
[AC_MSG_CHECKING([if Linux was built with symbol $1 exported])
grep -q -E '[[[:space:]]]$1[[[:space:]]]' $LINUX/$SYMVERFILE 2>/dev/null
rc=$?
if test $rc -ne 0; then
	export=0
	for file in $2; do
		grep -q -E "EXPORT_SYMBOL.*\($1\)" "$LINUX/$file" 2>/dev/null
		rc=$?
		if test $rc -eq 0; then
			export=1
			break;
		fi
	done
	if test $export -eq 0; then
		AC_MSG_RESULT([no])
		$4
	else
		AC_MSG_RESULT([yes])
		$3
	fi
else
	AC_MSG_RESULT([yes])
	$3
fi
])

#
# Like AC_CHECK_HEADER but checks for a kernel-space header
#
m4_define([LB_CHECK_LINUX_HEADER],
[AS_VAR_PUSHDEF([ac_Header], [ac_cv_header_$1])dnl
AC_CACHE_CHECK([for $1], ac_Header,
	       [LB_LINUX_COMPILE_IFELSE([LB_LANG_PROGRAM([@%:@include <$1>])],
				  [modules],
				  [test -s build/conftest.o],
				  [AS_VAR_SET(ac_Header, [yes])],
				  [AS_VAR_SET(ac_Header, [no])])])
AS_IF([test AS_VAR_GET(ac_Header) = yes], [$2], [$3])[]dnl
AS_VAR_POPDEF([ac_Header])dnl
])

#
# LB_USES_DPKG
#
# Determine if the target is a dpkg system or rpm
#
AC_DEFUN([LB_USES_DPKG],
[
AC_MSG_CHECKING([if this distro uses dpkg])
case `lsb_release -i -s 2>/dev/null` in
        Ubuntu | Debian)
                AC_MSG_RESULT([yes])
                uses_dpkg=yes
                ;;
        *)
                AC_MSG_RESULT([no])
                uses_dpkg=no
                ;;
esac
])

dnl #
dnl # Supported configure options.  When no options are specified support
dnl # for ZFS OSDs will be autodetected assuming server support is enabled.
dnl # If the ZFS OSD cannot be built support for it is disabled and a
dnl # warning is issued but the configure process is allowed to continue.
dnl #
dnl # --without-zfs   - Disable zfs support.
dnl # --with-zfs=no
dnl #
dnl # --with-zfs      - Enable zfs support and attempt to autodetect the zfs
dnl # --with-zfs=yes    headers in one of the following places.  Because zfs
dnl #                   support was explicitly required if the headers cannot
dnl #                   be located it is treated as a fatal error.
dnl #
dnl #                       * /var/lib/dkms/zfs/${VERSION}/build
dnl #                       * /usr/src/zfs-${VERSION}/${LINUXRELEASE}
dnl #                       * /usr/src/zfs-${VERSION}
dnl #                       * ../spl/
dnl #                       * $LINUX
dnl #
dnl # --with-zfs=path - Enable zfs support and use the zfs headers in the
dnl #                   provided path.  No autodetection is performed and
dnl #                   if no headers are found this is a fatal error.
dnl #
dnl # --with-zfs-obj  - When zfs support is enabled the object directory
dnl #                   will be based on the --with-zfs directory.  If this
dnl #                   is detected incorrectly it can be explicitly
dnl #                   specified using this option.
dnl #
dnl # --without-spl   - Disable spl support.
dnl # --with-spl=no
dnl #
dnl # --with-spl      - Enable spl support and attempt to autodetect the spl
dnl # --with-spl=yes    headers in one of the following places in this order:
dnl #                   * /var/lib/dkms/spl/${VERSION}/build
dnl #                   * /usr/src/spl-${VERSION}/${LINUXRELEASE}
dnl #                   * /usr/src/spl-${VERSION}
dnl #                   * ../spl/
dnl #                   * $LINUX
dnl #
dnl # --with-spl=path - Enable spl support and use the spl headers in the
dnl #                   provided path.  No autodetection is performed.
dnl #
dnl # --with-spl-obj  - When spl support is enabled the object directory
dnl #                   will be based on the --with-spl directory.  If this
dnl #                   is detected incorrectly it can be explicitly
dnl #                   specified using this option.
dnl #
AC_DEFUN([LB_SPL], [
	AC_ARG_WITH([spl],
		AS_HELP_STRING([--with-spl=PATH],
		[Path to spl source]),
		[splsrc="$withval"])

	AC_ARG_WITH([spl-obj],
		AS_HELP_STRING([--with-spl-obj=PATH],
		[Path to spl build objects]),
		[splobj="$withval"])

	dnl #
	dnl # The existence of spl.release[.in] is used to identify a valid
	dnl # source directory.  In order of preference:
	dnl #
	splver=$(ls -1 /usr/src/ | grep -m1 spl | cut -f2 -d'-')
	splsrc0="/var/lib/dkms/spl/${splver}/build"
	splsrc1="/usr/src/spl-${splver}/${LINUXRELEASE}"
	splsrc2="/usr/src/spl-${splver}"
	splsrc3="../spl/"
	splsrc4="$LINUX"

	AC_MSG_CHECKING([spl source directory])
	AS_IF([test -z "${splsrc}"], [
		AS_IF([test -e "${splsrc0}/spl.release.in"], [
			splsrc=${splsrc0}
		], [test -e "${splsrc1}/spl.release.in"], [
			splsrc=${splsrc1}
		], [test -e "${splsrc2}/spl.release.in"], [
			splsrc=${splsrc2}
		], [test -e "${splsrc3}/spl.release.in"], [
			splsrc=$(readlink -f "${splsrc3}")
		], [test -e "${splsrc4}/spl.release.in"], [
			splsrc=${splsrc4}
		], [
			splsrc="[Not found]"
		])
	])
	AC_MSG_RESULT([$splsrc])

	AS_IF([test ! -e "$splsrc/spl.release" &&
	    test ! -e "$splsrc/spl.release.in"], [
		enable_zfs=no
	])

	dnl #
	dnl # The existence of the spl_config.h is used to identify a valid
	dnl # spl object directory.  In many cases the object and source
	dnl # directory are the same, however the objects may also reside
	dnl # is a subdirectory named after the kernel version.
	dnl #
	AC_MSG_CHECKING([spl build directory])
	AS_IF([test -z "$splobj"], [
		AS_IF([test -e "${splsrc}/${LINUXRELEASE}/spl_config.h"], [
			splobj="${splsrc}/${LINUXRELEASE}"
		], [test -e "${splsrc}/spl_config.h"], [
			splobj="${splsrc}"
		], [
			splobj="[Not found]"
		])
	])
	AC_MSG_RESULT([$splobj])

	AS_IF([test ! -e "$splobj/spl_config.h"], [
		enable_zfs=no
	])

	dnl #
	dnl # Verify the source version using SPL_META_VERSION in spl_config.h
	dnl #
	AS_IF([test x$enable_zfs = xyes], [
		AC_MSG_CHECKING([spl source version])
		AS_IF([fgrep -q SPL_META_VERSION $splobj/spl_config.h], [
			splver=$((echo "#include <spl_config.h>";
			    echo "splver=SPL_META_VERSION-SPL_META_RELEASE") |
			    cpp -I $splobj |
			    grep "^splver=" | tr -d \" | cut -d= -f2)
		], [
			splver="[Not found]"
			enable_zfs=no
		])
		AC_MSG_RESULT([$splver])
	])

	dnl #
	dnl # Verify the modules systems exist by the expect name.
	dnl #
	AS_IF([test x$enable_zfs = xyes], [
		AC_MSG_CHECKING([spl file name for module symbols])
		AS_IF([test -r $splobj/$SYMVERFILE], [
			splsym=$SYMVERFILE
		], [test -r $splobj/module/$SYMVERFILE], [
			splsym=$SYMVERFILE
		], [
			splsym="[Not found]"
			enable_zfs=no
		])
		AC_MSG_RESULT([$splsym])
	])

	SPL=${splsrc}
	SPL_OBJ=${splobj}
	SPL_VERSION=${splver}
	SPL_SYMBOLS=${splsym}

	AC_SUBST(SPL)
	AC_SUBST(SPL_OBJ)
	AC_SUBST(SPL_VERSION)
	AC_SUBST(SPL_SYMBOLS)
])

AC_DEFUN([LB_ZFS], [
	AC_ARG_WITH([zfs-obj],
		AS_HELP_STRING([--with-zfs-obj=PATH],
		[Path to zfs build objects]),
		[zfsobj="$withval"])

	dnl #
	dnl # The existence of zfs.release[.in] is used to identify a valid
	dnl # source directory.  In order of preference:
	dnl #
	zfsver=$(ls -1 /usr/src/ | grep -m1 zfs | cut -f2 -d'-')
	zfssrc0="/var/lib/dkms/zfs/${zfsver}/build"
	zfssrc1="/usr/src/zfs-${zfsver}/${LINUXRELEASE}"
	zfssrc2="/usr/src/zfs-${zfsver}"
	zfssrc3="../zfs/"
	zfssrc4="$LINUX"

	AC_MSG_CHECKING([zfs source directory])
	AS_IF([test -z "${zfssrc}"], [
		AS_IF([test -e "${zfssrc0}/zfs.release.in"], [
			zfssrc=${zfssrc0}
		], [test -e "${zfssrc1}/zfs.release.in"], [
			zfssrc=${zfssrc1}
		], [test -e "${zfssrc2}/zfs.release.in"], [
			zfssrc=${zfssrc2}
		], [test -e "${zfssrc3}/zfs.release.in"], [
			zfssrc=$(readlink -f "${zfssrc3}")
		], [test -e "${zfssrc4}/zfs.release.in"], [
			zfssrc=${zfssrc4}
		], [
			zfssrc="[Not found]"
		])
	])
	AC_MSG_RESULT([$zfssrc])

	AS_IF([test ! -e "$zfssrc/zfs.release.in" &&
	    test ! -e "$zfssrc/zfs.release"], [
		enable_zfs=no
	])

	dnl #
	dnl # The existence of the zfs_config.h is used to identify a valid
	dnl # zfs object directory.  In many cases the object and source
	dnl # directory are the same, however the objects may also reside
	dnl # is a subdirectory named after the kernel version.
	dnl #
	AC_MSG_CHECKING([zfs build directory])
	AS_IF([test -z "$zfsobj"], [
		AS_IF([test -e "${zfssrc}/${LINUXRELEASE}/zfs_config.h"], [
			zfsobj="${zfssrc}/${LINUXRELEASE}"
		], [test -e "${zfssrc}/zfs_config.h"], [
			zfsobj="${zfssrc}"
		], [
			zfsobj="[Not found]"
		])
	])

	AC_MSG_RESULT([$zfsobj])
	AS_IF([test ! -e "$zfsobj/zfs_config.h"], [
		enable_zfs=no
	])

	dnl #
	dnl # Verify the source version using SPL_META_VERSION in spl_config.h
	dnl #
	AS_IF([test x$enable_zfs = xyes], [
		AC_MSG_CHECKING([zfs source version])
		AS_IF([fgrep -q ZFS_META_VERSION $zfsobj/zfs_config.h], [
			zfsver=$((echo "#include <zfs_config.h>";
			    echo "zfsver=ZFS_META_VERSION-ZFS_META_RELEASE") |
			    cpp -I $zfsobj |
			    grep "^zfsver=" | tr -d \" | cut -d= -f2)
		],[
			zfsver="[Not found]"
			enable_zfs=no
		])
		AC_MSG_RESULT([$zfsver])
	])

	dnl #
	dnl # Verify the modules systems exist by the expect name.
	dnl #
	AS_IF([test x$enable_zfs = xyes], [
		AC_MSG_CHECKING([zfs file name for module symbols])
		AS_IF([test -r $zfsobj/$SYMVERFILE], [
			zfssym=$SYMVERFILE
		], [test -r $zfsobj/module/$SYMVERFILE], [
			zfssym=$SYMVERFILE
		], [
			zfssym="[Not found]"
			enable_zfs=no
		])
		AC_MSG_RESULT([$zfssym])
	])

	ZFS=${zfssrc}
	ZFS_OBJ=${zfsobj}
	ZFS_VERSION=${zfsver}
	ZFS_SYMBOLS=${zfssym}

	AC_SUBST(ZFS)
	AC_SUBST(ZFS_OBJ)
	AC_SUBST(ZFS_VERSION)
	AC_SUBST(ZFS_SYMBOLS)
])

AC_DEFUN([LB_ZFS_USER], [
	dnl #
	dnl # Detect user space zfs development headers.
	dnl #
	AC_MSG_CHECKING([zfs devel headers])
	AS_IF([test -d /usr/include/libzfs && test -d /usr/include/libspl], [
		zfslib="-I /usr/include/libspl -I /usr/include/libzfs"
	], [
		zfslib="[Not found]"
		enable_zfs=no
	])
	AC_MSG_RESULT([$zfslib])

	ZFS_LIBZFS_INCLUDE=${zfslib}
	AC_SUBST(ZFS_LIBZFS_INCLUDE)
])

AC_DEFUN([LB_PATH_ZFS], [
	AC_ARG_WITH([zfs],
		[AS_HELP_STRING([--with-zfs=PATH], [Path to zfs source])],
		[
			AS_IF([test x$withval = xno], [
				enable_zfs=no
				require_zfs=no
			], [test x$withval = xyes], [
				enable_zfs=yes
				require_zfs=yes
			], [
				enable_zfs=yes
				require_zfs=yes
				zfssrc="$withval"
			])
		], [
			AS_IF([test x$enable_server = xyes &&
			    test x$enable_dist = xno], [
				require_zfs=no
				enable_zfs=yes
			], [
				require_zfs=no
				enable_zfs=no
			])
		])

	AC_MSG_CHECKING([whether to enable zfs])
	AC_MSG_RESULT([$enable_zfs])

	AS_IF([test x$enable_zfs = xyes], [
		AS_IF([test x$enable_modules = xyes], [
			LB_SPL
			LB_ZFS
		])

		LB_ZFS_USER

		dnl #
		dnl # enable_zfs will be set to no in LB_SPL or LB_ZFS if
		dnl # one of more of the build requirements is not met.
		dnl #
		AS_IF([test x$enable_zfs = xyes], [
			AC_DEFINE(HAVE_ZFS_OSD, 1, Enable zfs osd)
		],[
			AS_IF([test x$require_zfs = xyes], [
				AC_MSG_ERROR([

Required zfs osd cannot be built due to missing zfs development headers.

Support for zfs can be enabled by downloading the required packages for your
distribution.  See http://zfsonlinux.org/ to determine is zfs is supported by
your distribution.
				])
			], [
				AC_MSG_WARN([

Disabling optional zfs osd due to missing development headers.

Support for zfs can be enabled by downloading the required packages for your
distribution.  See http://zfsonlinux.org/ to determine is zfs is supported by
your distribution.
				])
			])
		])
	])

	AM_CONDITIONAL(ZFS_ENABLED, test x$enable_zfs = xyes)
])

#
# LB_CHECK_VERSION
#
# Verify that LUSTRE_VERSION was defined properly
#
AC_DEFUN([LB_CHECK_VERSION],
[if test "LUSTRE_VERSION" = "LUSTRE""_VERSION" ; then
	AC_MSG_ERROR([This script was not built with a version number.])
fi
])

#
# LB_CANONICAL_SYSTEM
#
# fixup $target_os for use in other places
#
AC_DEFUN([LB_CANONICAL_SYSTEM],
[case $target_os in
	linux*)
		lb_target_os="linux"
		;;
	darwin*)
		lb_target_os="darwin"
		;;
	solaris*)
		lb_target_os="SunOS"
		;;esac
AC_SUBST(lb_target_os)
])

#
# LB_DOWNSTREAM_RELEASE
#
AC_DEFUN([LB_DOWNSTREAM_RELEASE],
[AC_ARG_WITH([downstream-release],
	AC_HELP_STRING([--with-downstream-release=string],
		       [set a string in the BUILD_VERSION and RPM Release: (default is nothing)]),
	[DOWNSTREAM_RELEASE=$with_downstream_release],
	[
	# if not specified, see if it's in the META file
	if test -f META; then
		DOWNSTREAM_RELEASE=$(sed -ne '/^LOCAL_VERSION =/s/.*= *//p' META)
	fi
	])
AC_SUBST(DOWNSTREAM_RELEASE)
])

#
# LB_BUILDID
#
# Check if the source is a GA release and if not, set a "BUILDID"
#
# Currently there are at least two ways/modes of/for doing this.  One
# is if we are in a valid git repository, the other is if we are in a
# non-git source tree of some form.  Building the latter from the former
# will be handled here.
AC_DEFUN([LB_BUILDID],
[
AC_MSG_CHECKING([for buildid])
BUILDID=""
if git branch >/dev/null 2>&1; then
	ffw=0
	hash=""
	ver=$(git describe --match v[[0-9]]_*_[[0-9]]* --tags)
	if [[[ $ver = *-*-* ]]]; then
		hash=${ver##*-}
		ffw=${ver#*-}
		ffw=${ffw%-*}
		ver=${ver%%-*}
	fi
	# it's tempting to use [[ $ver =~ ^v([0-9]+_)+([0-9]+|RC[0-9]+)$ ]]
	# here but the portability of the regex on the right is dismal
	# (thanx suse)
	if echo "$ver" | egrep -q "^v([[0-9]]+_)+([[0-9]]+|RC[[0-9]]+)$"; then
		ver=$(echo $ver | sed -e 's/^v\(.*\)/\1/' \
				      -e 's/_RC[[0-9]].*$//' -e 's/_/./g')
	fi

	# a "lustre fix" value of .0 should be truncated
	if [[[ $ver = *.*.*.0 ]]]; then
		ver=${ver%.0}
	fi
	# ditto for a "lustre fix" value of _0
	if [[[ $ver = v*_*_*_0 ]]]; then
		ver=${ver%_0}
	fi
	if [[[ $ver = v*_*_* ]]]; then
		ver=${ver#v}
		ver=${ver//_/.}
	fi

	# only do this test for lustre (not ldiskfs)
	if test "$PACKAGE" = "lustre" -a "$ver" != "$VERSION"; then
		AC_MSG_WARN([most recent tag found: $ver does not match current version $VERSION.])
	fi

	if test "$ffw" != "0"; then
		BUILDID="$hash"
		msg="$BUILDID (ahead by $ffw commits)"
		AC_MSG_RESULT([$msg])
	else
		AC_MSG_RESULT([none... congratulations, you must be on a tag])
	fi
elif test -f META; then
	BUILDID=$(sed -ne '/^BUILDID =/s/.*= *//p' META)
	msg="$BUILDID (from META file)"
	AC_MSG_RESULT([$msg])
else
	AC_MSG_WARN([FIXME: I don't know how to deal with source trees outside of git that don't have a META file.  Not setting a buildid.])
fi
AC_SUBST(BUILDID)
])

#
# LB_CHECK_FILE
#
# Check for file existance even when cross compiling
#
AC_DEFUN([LB_CHECK_FILE],
[AS_VAR_PUSHDEF([lb_File], [lb_cv_file_$1])dnl
AC_CACHE_CHECK([for $1], lb_File,
[if test -r "$1"; then
	AS_VAR_SET(lb_File, yes)
else
	AS_VAR_SET(lb_File, no)
fi])
AS_IF([test AS_VAR_GET(lb_File) = yes], [$2], [$3])[]dnl
AS_VAR_POPDEF([lb_File])dnl
])# LB_CHECK_FILE


#
# LB_ARG_LIBS_INCLUDES
#
# support for --with-foo, --with-foo-includes, and --with-foo-libs in
# a single magical macro
#
AC_DEFUN([LB_ARG_LIBS_INCLUDES],
[lb_pathvar="m4_bpatsubst([$2], -, _)"
AC_MSG_CHECKING([for $1])
AC_ARG_WITH([$2],
	AC_HELP_STRING([--with-$2=path],
		[path to $1]),
	[],[withval=$4])

if test x$withval = xyes ; then
	eval "$lb_pathvar='$3'"
else
	eval "$lb_pathvar='$withval'"
fi
AC_MSG_RESULT([${!lb_pathvar:-no}])

if test x${!lb_pathvar} != x -a x${!lb_pathvar} != xno ; then
	AC_MSG_CHECKING([for $1 includes])
	AC_ARG_WITH([$2-includes],
		AC_HELP_STRING([--with-$2-includes=path],
			[path to $1 includes]),
		[],[withval='yes'])

	lb_includevar="${lb_pathvar}_includes"
	if test x$withval = xyes ; then
		eval "${lb_includevar}='${!lb_pathvar}/include'"
	else
		eval "${lb_includevar}='$withval'"
	fi
	AC_MSG_RESULT([${!lb_includevar}])

	AC_MSG_CHECKING([for $1 libs])
	AC_ARG_WITH([$2-libs],
		AC_HELP_STRING([--with-$2-libs=path],
			[path to $1 libs]),
		[],[withval='yes'])

	lb_libvar="${lb_pathvar}_libs"
	if test x$withval = xyes ; then
		eval "${lb_libvar}='${!lb_pathvar}/lib'"
	else
		eval "${lb_libvar}='$withval'"
	fi
	AC_MSG_RESULT([${!lb_libvar}])
fi
])
])

#
# LB_PATH_LIBSYSIO
#
# Handle internal/external libsysio
#
AC_DEFUN([LB_PATH_LIBSYSIO],
[AC_ARG_WITH([sysio],
	AC_HELP_STRING([--with-sysio=path],
			[set path to libsysio source (default is included libsysio)]),
	[],[
		case $lb_target_os in
			linux)
				with_sysio='yes'
				;;
			*)
				with_sysio='no'
				;;
		esac
	])
AC_MSG_CHECKING([location of libsysio])
enable_sysio="$with_sysio"
case x$with_sysio in
	xyes)
		AC_MSG_RESULT([internal])
		LB_CHECK_FILE([$srcdir/libsysio/src/rmdir.c],[],[
			AC_MSG_ERROR([A complete internal libsysio was not found.])
		])
		LIBSYSIO_SUBDIR="libsysio"
		SYSIO="$PWD/libsysio"
		;;
	xno)
		AC_MSG_RESULT([disabled])
		;;
	*)
		AC_MSG_RESULT([$with_sysio])
		LB_CHECK_FILE([$with_sysio/lib/libsysio.a],[],[
			AC_MSG_ERROR([A complete (built) external libsysio was not found.])
		])
		SYSIO=$with_sysio
		with_sysio="yes"
		;;
esac

# We have to configure even if we don't build here for make dist to work
AC_CONFIG_SUBDIRS(libsysio)
])

#
# LB_PATH_LUSTREIOKIT
#
# Handle internal/external lustre-iokit
#
AC_DEFUN([LB_PATH_LUSTREIOKIT],
[AC_ARG_WITH([lustre-iokit],
	AC_HELP_STRING([--with-lustre-iokit=path],
			[set path to lustre-iokit source (default is included lustre-iokit)]),
	[],[
			with_lustre_iokit='yes'
	])
AC_MSG_CHECKING([location of lustre-iokit])
enable_lustre_iokit="$with_lustre_iokit"
case x$with_lustre_iokit in
	xyes)
		AC_MSG_RESULT([internal])
		LB_CHECK_FILE([$srcdir/lustre-iokit/ior-survey/ior-survey],[],[
			AC_MSG_ERROR([A complete internal lustre-iokit was not found.])
		])
		LUSTREIOKIT_SUBDIR="lustre-iokit"
		LUSTREIOKIT="$PWD/lustre-iokit"
		;;
	xno)
		AC_MSG_RESULT([disabled])
		;;
	*)
		AC_MSG_RESULT([$with_lustre_iokit])
		LB_CHECK_FILE([$with_lustre_iokit/ior-survey/ior_survey],[],[
			AC_MSG_ERROR([A complete (built) external lustre-iokit was not found.])
		])
		LUSTREIOKIT="$with_lustre_iokit"
		;;
esac
AC_SUBST(LUSTREIOKIT_SUBDIR)
# We have to configure even if we don't build here for make dist to work
AC_CONFIG_SUBDIRS(lustre-iokit)
])

# Define no libcfs by default.
AC_DEFUN([LB_LIBCFS_DIR],
[
case x$libcfs_is_module in
	xyes)
          LIBCFS_INCLUDE_DIR="libcfs/include"
          LIBCFS_SUBDIR="libcfs"
          ;;
        x*)
          LIBCFS_INCLUDE_DIR="lnet/include"
          LIBCFS_SUBDIR=""
          ;;
esac
AC_SUBST(LIBCFS_SUBDIR)
AC_SUBST(LIBCFS_INCLUDE_DIR)
])

#
# LB_PATH_SNMP
#
# check for in-tree snmp support
#
AC_DEFUN([LB_PATH_SNMP],
[LB_CHECK_FILE([$srcdir/snmp/lustre-snmp.c],[SNMP_DIST_SUBDIR="snmp"])
AC_SUBST(SNMP_DIST_SUBDIR)
AC_SUBST(SNMP_SUBDIR)
])

#
# LB_CONFIG_MODULES
#
# Build kernel modules?
#
AC_DEFUN([LB_CONFIG_MODULES],
[AC_MSG_CHECKING([whether to build kernel modules])
AC_ARG_ENABLE([modules],
	AC_HELP_STRING([--disable-modules],
			[disable building of Lustre kernel modules]),
	[],[
		LC_TARGET_SUPPORTED([
			enable_modules='yes'
		],[
			enable_modules='no'
		])
	])
AC_MSG_RESULT([$enable_modules ($target_os)])

if test x$enable_modules = xyes ; then
	case $target_os in
		linux*)
			LB_PROG_LINUX
			LIBCFS_PROG_LINUX
			LN_PROG_LINUX
			LC_PROG_LINUX
			;;
		darwin*)
			LB_PROG_DARWIN
			LIBCFS_PROG_DARWIN
			;;
		*)
			# This is strange - Lustre supports a target we don't
			AC_MSG_ERROR([Modules are not supported on $target_os])
			;;
	esac
fi
])

#
# LB_CONFIG_UTILS
#
# Build utils?
#
AC_DEFUN([LB_CONFIG_UTILS],
[AC_MSG_CHECKING([whether to build utilities])
AC_ARG_ENABLE([utils],
	AC_HELP_STRING([--disable-utils],
			[disable building of Lustre utility programs]),
	[],[enable_utils='yes'])
AC_MSG_RESULT([$enable_utils])
if test x$enable_utils = xyes ; then 
	LB_CONFIG_INIT_SCRIPTS
fi
])

#
# LB_CONFIG_TESTS
#
# Build tests?
#
AC_DEFUN([LB_CONFIG_TESTS],
[AC_MSG_CHECKING([whether to build Lustre tests])
AC_ARG_ENABLE([tests],
	AC_HELP_STRING([--disable-tests],
			[disable building of Lustre tests]),
	[],
	[
		enable_tests='yes'
	])
AC_MSG_RESULT([$enable_tests])
])

#
# LB_CONFIG_DIST
#
# Just enough configure so that "make dist" is useful
#
# this simply re-adjusts some defaults, which of course can be overridden
# on the configure line after the --for-dist option
#
AC_DEFUN([LB_CONFIG_DIST],
[AC_MSG_CHECKING([whether to configure just enough for make dist])
AC_ARG_ENABLE([dist],
	AC_HELP_STRING([--enable-dist],
			[only configure enough for make dist]),
	[enable_dist='yes'],[enable_dist='no'])
AC_MSG_RESULT([$enable_dist])
if test x$enable_dist != xno; then
	enable_modules='no'
	enable_utils='no'
        enable_liblustre='no'
        enable_doc='no'
        enable_tests='no'
fi
])

#
# LB_CONFIG_DOCS
#
# Build docs?
#
AC_DEFUN([LB_CONFIG_DOCS],
[AC_MSG_CHECKING([whether to build docs])
AC_ARG_ENABLE(doc,
	AC_HELP_STRING([--disable-doc],
			[skip creation of pdf documentation]),
	[
		if test x$enable_doc = xyes ; then
		    ENABLE_DOC=1
		else
		    ENABLE_DOC=0
		fi
	],[
		ENABLE_DOC=0
		enable_doc='no'
	])
AC_MSG_RESULT([$enable_doc])
AC_SUBST(ENABLE_DOC)
])

#
# LB_CONFIG_INIT_SCRIPTS
#
# our init scripts only work on red hat linux
#
AC_DEFUN([LB_CONFIG_INIT_SCRIPTS],
[ENABLE_INIT_SCRIPTS=0
if test x$enable_utils = xyes ; then
        AC_MSG_CHECKING([whether to install init scripts])
        # our scripts only work on red hat systems
        if test -f /etc/init.d/functions -a -f /etc/sysconfig/network ; then
                ENABLE_INIT_SCRIPTS=1
                AC_MSG_RESULT([yes])
        else
                AC_MSG_RESULT([no])
        fi
fi
AC_SUBST(ENABLE_INIT_SCRIPTS)
])

#
# LB_CONFIG_HEADERS
#
# add -include config.h
#
AC_DEFUN([LB_CONFIG_HEADERS],[
	AC_CONFIG_HEADERS([config.h])
	CPPFLAGS="-include $PWD/config.h $CPPFLAGS"
	EXTRA_KCFLAGS="-include $PWD/config.h $EXTRA_KCFLAGS"
	AC_SUBST(EXTRA_KCFLAGS)
])

#
# LB_INCLUDE_RULES
#
# defines for including the toplevel Rules
#
AC_DEFUN([LB_INCLUDE_RULES],[
	INCLUDE_RULES="include $PWD/Rules"
	AC_SUBST(INCLUDE_RULES)
])

#
# LB_PATH_DEFAULTS
#
# 'fixup' default paths
#
AC_DEFUN([LB_PATH_DEFAULTS],
[# directories for binaries
AC_PREFIX_DEFAULT([/usr])

sysconfdir='$(CROSS_PATH)/etc'
AC_SUBST(sysconfdir)

# Directories for documentation and demos.
docdir='$(datadir)/doc/$(PACKAGE)'
AC_SUBST(docdir)

LIBCFS_PATH_DEFAULTS
LN_PATH_DEFAULTS
LC_PATH_DEFAULTS

])

#
# LB_PROG_CC
#
# checks on the C compiler
#
AC_DEFUN([LB_PROG_CC],
[AC_PROG_RANLIB
AC_CHECK_TOOL(LD, ld, [no])
AC_CHECK_TOOL(OBJDUMP, objdump, [no])
AC_CHECK_TOOL(STRIP, strip, [no])

# ---------  unsigned long long sane? -------
AC_CHECK_SIZEOF(unsigned long long, 0)
echo "---> size SIZEOF $SIZEOF_unsigned_long_long"
echo "---> size SIZEOF $ac_cv_sizeof_unsigned_long_long"
if test $ac_cv_sizeof_unsigned_long_long != 8 ; then
	AC_MSG_ERROR([** we assume that sizeof(long long) == 8.])
fi

if test $target_cpu == "powerpc64"; then
	AC_MSG_WARN([set compiler with -m64])
	CFLAGS="$CFLAGS -m64"
	CC="$CC -m64"
fi

CPPFLAGS="-I$PWD/$LIBCFS_INCLUDE_DIR -I$PWD/lnet/include -I$PWD/lustre/include $CPPFLAGS"

LLCPPFLAGS="-D__arch_lib__ -D_LARGEFILE64_SOURCE=1"
AC_SUBST(LLCPPFLAGS)

# Add _GNU_SOURCE for strnlen on linux
LLCFLAGS="-g -Wall -fPIC -D_GNU_SOURCE"
AC_SUBST(LLCFLAGS)

CCASFLAGS="-Wall -fPIC -D_GNU_SOURCE"
AC_SUBST(CCASFLAGS)

# everyone builds against lnet and lustre
EXTRA_KCFLAGS="$EXTRA_KCFLAGS -g -I$PWD/$LIBCFS_INCLUDE_DIR -I$PWD/lnet/include -I$PWD/lustre/include"
AC_SUBST(EXTRA_KCFLAGS)
])

#
# LB_CONTITIONALS
#
# AM_CONDITIONAL instances for everything
# (so that portals/lustre can disable some if needed)
AC_DEFUN([LB_CONDITIONALS],
[AM_CONDITIONAL(MODULES, test x$enable_modules = xyes)
AM_CONDITIONAL(UTILS, test x$enable_utils = xyes)
AM_CONDITIONAL(TESTS, test x$enable_tests = xyes)
AM_CONDITIONAL(DOC, test x$ENABLE_DOC = x1)
AM_CONDITIONAL(INIT_SCRIPTS, test x$ENABLE_INIT_SCRIPTS = "x1")
AM_CONDITIONAL(LINUX, test x$lb_target_os = "xlinux")
AM_CONDITIONAL(DARWIN, test x$lb_target_os = "xdarwin")
AM_CONDITIONAL(SUNOS, test x$lb_target_os = "xSunOS")
AM_CONDITIONAL(USES_DPKG, test x$uses_dpkg = "xyes")
AM_CONDITIONAL(ARCH_x86, test x$target_cpu = "xx86_64" -o x$target_cpu = "xi686")
AM_CONDITIONAL(ARCH_MIC, test x$target_cpu = "xx86_64" -a x$target_vendor = "xk1om")

# Sanity check for PCLMULQDQ instruction availability
# PCLMULQDQ instruction is a new instruction available beginning with
# the all new Core processor family based on the 32nm microarchitecture
# codename Westmere. So, $target_cpu = x86_64 should have this instruction
# except MIC microarchitecture (k1om).
AM_CONDITIONAL(HAVE_PCLMULQDQ, test x$target_cpu = "xx86_64" -a x$target_vendor != "xk1om")
if test x$target_cpu = "xx86_64" -a x$target_vendor != "xk1om" ; then
	AC_DEFINE(HAVE_PCLMULQDQ, 1, [have PCLMULQDQ instruction])
fi

# this lets lustre cancel libsysio, per-branch or if liblustre is
# disabled
if test "x$LIBSYSIO_SUBDIR" = xlibsysio ; then
	if test "x$with_sysio" != xyes ; then
		SYSIO=""
		LIBSYSIO_SUBDIR=""
	fi
fi
AC_SUBST(LIBSYSIO_SUBDIR)
AC_SUBST(SYSIO)

LB_DARWIN_CONDITIONALS

LIBCFS_CONDITIONALS
LN_CONDITIONALS
LC_CONDITIONALS
])

#
# LB_CONFIG_FILES
#
# build-specific config files
#
AC_DEFUN([LB_CONFIG_FILES],
[
	AC_CONFIG_FILES([
		Makefile
		autoMakefile]
		config/Makefile
		[Rules:build/Rules.in]
		AC_PACKAGE_TARNAME[.spec]
		AC_PACKAGE_TARNAME[-dkms.spec]
		contrib/Makefile
		contrib/lbuild/Makefile
		contrib/scripts/Makefile
	)
])

#
# LB_CONFIGURE
#
# main configure steps
#
AC_DEFUN([LB_CONFIGURE],
[LB_CANONICAL_SYSTEM

LB_CONFIG_DIST

LB_DOWNSTREAM_RELEASE
LB_USES_DPKG
LB_BUILDID

LB_LIBCFS_DIR

LB_INCLUDE_RULES

LB_PATH_DEFAULTS

LB_PROG_CC

LC_OSD_ADDON

LB_CONFIG_DOCS
LB_CONFIG_UTILS
LB_CONFIG_TESTS
LC_CONFIG_CLIENT_SERVER

# two macros for cmd3
m4_ifdef([LC_CONFIG_SPLIT], [LC_CONFIG_SPLIT])
LN_CONFIG_CDEBUG
LC_QUOTA

LB_CONFIG_MODULES
LN_CONFIG_USERSPACE

LB_PATH_LIBSYSIO
LB_PATH_SNMP
LB_PATH_LDISKFS
LB_PATH_ZFS
LB_PATH_LUSTREIOKIT

LB_DEFINE_E2FSPROGS_NAMES

LC_CONFIG_LIBLUSTRE
LIBCFS_CONFIGURE
LN_CONFIGURE

LC_CONFIGURE

if test "$SNMP_DIST_SUBDIR" ; then
	LS_CONFIGURE
fi


LB_CONDITIONALS
LB_CONFIG_HEADERS

LIBCFS_CONFIG_FILES
LB_CONFIG_FILES
LN_CONFIG_FILES
LC_CONFIG_FILES
if test "$SNMP_DIST_SUBDIR" ; then
	LS_CONFIG_FILES
fi

AC_SUBST(ac_configure_args)

MOSTLYCLEANFILES='.*.cmd .*.flags *.o *.ko *.mod.c .depend .*.1.* Modules.symvers Module.symvers'
AC_SUBST(MOSTLYCLEANFILES)

AC_OUTPUT

cat <<_ACEOF

CC:            $CC
LD:            $LD
CPPFLAGS:      $CPPFLAGS
LLCPPFLAGS:    $LLCPPFLAGS
CFLAGS:        $CFLAGS
EXTRA_KCFLAGS: $EXTRA_KCFLAGS
LLCFLAGS:      $LLCFLAGS

Type 'make' to build Lustre.
_ACEOF
])

