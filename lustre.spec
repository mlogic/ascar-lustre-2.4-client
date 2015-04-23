# lustre.spec
%{!?version: %global version 2.4.0}
%{!?kver: %global kver ""}
%{!?kdir: %global kdir %(dir=$(echo "%configure_args" | sed -ne 's/.*--with-linux=\\([^ ][^ ]*\\).*$/\\1/p'); if [ -n "$dir" ]; then echo "$dir"; else if [ -n "%kver" ]; then kversion="%kver"; else kversion="$(uname -r)"; fi; echo "/lib/modules/$kversion/source"; fi)}

%{!?kobjdir: %global kobjdir %(dir=$(echo "%configure_args" | sed -ne 's/.*--with-linux-obj=\\([^ ][^ ]*\\).*$/\\1/p'); if [ -n "$dir" ]; then echo "$dir"; else if [ -n "%kver" ]; then kversion="%kver"; else kversion="$(uname -r)"; fi; if [ "%kdir" = "/lib/modules/$kversion/source" ]; then echo "/lib/modules/$kversion/build"; else echo "%kdir"; fi; fi)}

# as an alternative to this implementation we could simply "make -C $kdir kernelversion"
%{!?kversion: %global kversion %(if test -s %kobjdir/include/generated/utsrelease.h ; then LINUXRELEASEHEADER=%kobjdir/include/generated/utsrelease.h ; elif test -s %kobjdir/include/linux/utsrelease.h ; then LINUXRELEASEHEADER=%kobjdir/include/linux/utsrelease.h ; else LINUXRELEASEHEADER=%kobjdir/include/linux/version.h; fi; sed -ne '/^#define UTS_RELEASE/s/.*"\\(.*\\)"$/\\1/p' $LINUXRELEASEHEADER)}

%{!?downstream_release: %global downstream_release ""}

%define buildid %(if [ -n "" ]; then echo "_"; fi)

%{!?myrelease: %global myrelease %(if [ -n "%downstream_release" ]; then echo -n "%{downstream_release}_"; fi; echo %kversion | tr '-' '_')}

# always append the buildid, even when the caller defines %release
%define fullrelease %{myrelease}%{buildid}

%{!?lustre_name: %global lustre_name lustre}
%{!?build_lustre_tests: %global build_lustre_tests 1}

%{!?build_lustre_modules: %global build_lustre_modules 0}
%{!?build_lustre_osd_ldiskfs: %global build_lustre_osd_ldiskfs 0}
%{!?build_lustre_osd_zfs: %global build_lustre_osd_zfs 1}

# in order to get kernel symset and/or kernel module dependencies into
# the RPM, in order to support weak-modules, the internal dependency gen-
# erator needs to be disabled
# this is done with (reduce the double % down to a single %):
#
# %%global _use_internal_dependency_generator 0
#
# on SLES10, /usr/lib/rpm/macros already sets this, so no harm in also
# defining it here (until Suse changes their mind)
#
# on RHEL5, however, we do need to explicitly disable the internal dep-
# endency generator and allow the external one be used
# but since RedHat's kABI is only a subset of the total kernel ABI, it
# doesn't include all of the symbols we (or OFED for that matter) need
# until RedHat includes all of the symbols we need in their symsets we
# cannot support weak-modules
# we did e-mail the maintainer of all of this stuff @redhat but got no
# response from them
#%%global _use_internal_dependency_generator 0

%define is_client %(bash -c "if [[ %{lustre_name} = *-client* ]]; then echo -n '1'; else echo -n '0'; fi")
# for those uses that don't want the -smp/-bigsmp (or the .arch) on the end
# of %kversion
%define krequires %(bash -c "echo %{kversion} | sed -e 's/\.x86_64$//' -e 's/\.i[3456]86$//' -e 's/-smp$//' -e 's/-bigsmp$//' -e 's/-ppc64$//' -e 's/-default$//'")

%define sles10 %(bash -c "if [ "%sles_version" = "10" ]; then echo -n '1'; else echo -n '0'; fi")

%if %sles10
%define flavor %(bash -c "echo %{kversion} | sed -e 's/^.*-//'")
%endif

%if %is_client
%define build_lustre_osd_ldiskfs 0
%define build_lustre_osd_zfs 0
%endif

%if %{defined cross_path} && %{defined post_script}
%define rpm_post_base %(echo $(dirname %{cross_path})/%{lustre_name})
%endif

Summary: Lustre File System
Name: %{lustre_name}
Version: %{version}
Release: 1%{?dist}
License: GPL
Group: Utilities/System
Source: lustre-%{version}.tar.gz
URL: http://wiki.whamcloud.com/
BuildRoot: %{_tmppath}/lustre-%{version}-root
Obsoletes: lustre-lite, lustre-lite-utils, lustre-ldap nfs-utils-lustre
Provides: lustre-lite = %{version}, lustre-lite-utils = %{version}
Requires: %{name}-modules = %{version}
%if ! %{is_client}
Requires: lustre-osd
%endif
# GSS requires this: BuildRequires: pkgconfig, libgssapi-devel >= 0.10
%if %{build_lustre_osd_zfs}
BuildRequires: zfs-devel
Requires: zfs-devel
%endif

%description
Userspace tools and files for the Lustre file system.

%if %{build_lustre_modules}
%package modules
Summary: Kernel Lustre modules for Linux %{kversion}
%if %{defined cross_requires}
Requires: %{cross_requires}
%else
# for SLES11, we need nothing here
# for SLES10, we need (where %{flavor} is, i.e. smp):
%if %sles10
Requires: kernel-%{flavor}
%else
%if %{_vendor}=="redhat" || %{_vendor}=="fedora"
# for RHEL we need to require the specific kernel still since weak-modules
# support on RH is, well, weak, to be punny about it
Requires: kernel = %{krequires}
%endif
%endif
%endif
Group: Development/Kernel

%description modules
Lustre file system, server and network drivers for Linux %{kversion}.

%if %{build_lustre_osd_ldiskfs}
%package osd-ldiskfs
Summary: osd-ldiskfs is the mandatory glue for LDISKFS support in Lustre.
Requires: lustre-modules = %{version}, lustre-ldiskfs >= 4.1.0
Provides: lustre-osd
Group: Development/Kernel

%description osd-ldiskfs
The Lustre Object Storage Device (OSD) API is the interface to access and
modify data that is supposed to be stored persistently. This API is the interface
to code that bridges individual file systems. This specific package provides an
implementation of the OSD API for using the Ldiskfs filesystem as the underlying
backing store of a Lustre server.
%endif

%if %{build_lustre_osd_zfs}
%package osd-zfs
Summary: osd-zfs is the mandatory glue for ZFS support in Lustre.
Requires: %{lustre_name}-modules = %{version}, zfs-kmod
BuildRequires: zfs-devel zfs-devel-kmod spl-devel-kmod
Provides: lustre-osd
Group: Development/Kernel

%description osd-zfs
The Lustre Object Storage Device (OSD) API is the interface to access and
modify data that is supposed to be stored persistently. This API is the interface
to code that bridges individual file systems. This specific package provides an
implementation of the OSD API for using the ZFS filesystem as the underlying
backing store of a Lustre server.
%endif
%endif

%package source
Summary: Object-Based Disk storage driver source
Group: Development/Kernel

%description source
Lustre sources for further development

# Since the RPMs we ship are to be used on both SLES and RHEL, we
# can't include any dependency information (since the package names
# are different on the two platforms).
#
# Instead, we can build these empty meta-packages that only include
# dependency information.  These let people get the correct
# dependencies for their platform and lets them use tools like yum and
# red carpet to install the correct files.
#
# Unfortunately I have not seen this come up on the lists much, so I
# have disabled them (by commenting out their empty files section
# below) until it's clear that they resolve more confusion than they
# add.

%package deps-sles
Summary: Lustre dependencies meta-package for SLES
Group: Utilities/System
Provides: lustre-deps = %{version}
Requires: %{name} = %{version}, sles-release
Conflicts: %{name}-deps-rhel

%description deps-sles
This package has RPM dependencies appropriate for SLES systems.

%package deps-rhel
Summary: Lustre dependencies meta-package for RHEL
Group: Utilities/System
Provides: lustre-deps = %{version}
Requires: %{name} = %{version}, redhat-release
Conflicts: %{name}-deps-sles

%description deps-rhel
This package has RPM dependencies appropriate for RHEL, RHL, and FC
systems.

%package tests
Summary: Lustre testing framework
Group: Development/Kernel
Provides: %{name}-tests = %{version}
Requires: %{name} = %{version}, %{name}-modules = %{version}

%description tests
This package contains a set of test binaries and scripts that are intended
to be used by the Lustre testing framework.

%if 0%{?suse_version}
%debug_package
%endif
%prep
%setup -qn lustre-%{version}
ln lustre/ChangeLog ChangeLog-lustre
ln lnet/ChangeLog ChangeLog-lnet

%build
# if RPM_BUILD_NCPUS unset, set it
if [ -z "$RPM_BUILD_NCPUS" ] ; then
    RPM_BUILD_NCPUS=$(egrep -c "^cpu[0-9]+" /proc/stat 2>/dev/null || echo 0 :)
    if [ $RPM_BUILD_NCPUS -eq 0 ] ; then
        RPM_BUILD_NCPUS=1
    fi
    if [ $RPM_BUILD_NCPUS -gt 8 ] ; then
        RPM_BUILD_NCPUS=8
    fi
fi

rm -rf $RPM_BUILD_ROOT

# Set an explicit path to our Linux tree, if we can.
cd $RPM_BUILD_DIR/lustre-%{version}
# override %optflags so that the vendor's overzealous flags don't create
# build failures
%define optflags -g -O2 -Werror
CONFIGURE_ARGS="%{?configure_args} --with-release=%release"
%if %{build_lustre_tests}
CONFIGURE_ARGS="$CONFIGURE_ARGS --enable-tests --enable-liblustre-tests"
%else
CONFIGURE_ARGS="$CONFIGURE_ARGS --disable-tests --disable-liblustre-tests"
%endif

%if %{build_lustre_modules}
CONFIGURE_ARGS="$CONFIGURE_ARGS --enable-modules"
%else
CONFIGURE_ARGS="$CONFIGURE_ARGS --disable-modules"
%endif

# May be enabled when build_lustre_modules=0 to enable utility support.
%if %{build_lustre_osd_ldiskfs}
CONFIGURE_ARGS="$CONFIGURE_ARGS --with-ldiskfs"
%else
CONFIGURE_ARGS="$CONFIGURE_ARGS --without-ldiskfs"
%endif

# May be enabled when build_lustre_modules=0 to enable utility support.
%if %{build_lustre_osd_zfs}
CONFIGURE_ARGS="$CONFIGURE_ARGS --with-zfs"
%else
CONFIGURE_ARGS="$CONFIGURE_ARGS --without-zfs"
%endif

# if %%kdir was given, make sure it's not in the configure arguments
if [ -n "%kdir" ]; then
	CONFIGURE_ARGS=$(echo $CONFIGURE_ARGS | sed -e 's/"\?--with-linux=[^ ][^ ]* \?//')
fi
# ditto for %%kobjdir
if [ -n "%kobjdir" ]; then
	CONFIGURE_ARGS=$(echo $CONFIGURE_ARGS | sed -e 's/"\?--with-linux-obj=[^ ][^ ]* \?//')
fi

# we need to eval "configure" because $CONFIGURE_ARGS could have a quoted
# string in it which we don't want word splitted by the shell
# also remove (build|host|target) options because they will be specified
# inside $CONFIGURE_ARGS
%define eval_configure %(echo '%configure' | sed -e 's#\./configure#eval ./configure#' -e 's/--\\(build\\|host\\|target\\)=[^ ][^ ]* //g')

%eval_configure \
	%{?kdir: --with-linux=%kdir} %{?kobjdir: --with-linux-obj=%kobjdir} \
	$CONFIGURE_ARGS
make -j $RPM_BUILD_NCPUS -s %{?make_args}

%install
make install DESTDIR=$RPM_BUILD_ROOT
# hack to avoid changing the libsysio code for "make install"
rm -f $RPM_BUILD_ROOT%{_libdir}/libsysio.a
# Remove ldiskfs module(s) - they are packaged by the ldiskfs .spec.
rm -rf $RPM_BUILD_ROOT%{?rootdir}/lib/modules/%{kversion}/updates/kernel/fs/lustre-ldiskfs

# hack to include the llog_test module in lustre-tests
llog_base=$RPM_BUILD_DIR/lustre-%{version}/lustre/obdclass/llog_test
if [ -e ${llog_base}.ko ]; then
  cp ${llog_base}.ko $RPM_BUILD_ROOT%{?rootdir}/lib/modules/%{kversion}/updates/kernel/fs/lustre
elif [ -e ${llog_base}.o ]; then
  cp ${llog_base}.o $RPM_BUILD_ROOT%{?rootdir}/lib/modules/%{kversion}/updates/kernel/fs/lustre
fi

# The .ha_v2 extension identifies the heartbeat resource agent as using
# legacy syntax. Install a compatibility symlink to avoid conflicts when
# newer-style agents are added.
ln -s Lustre.ha_v2 $RPM_BUILD_ROOT%{_sysconfdir}/ha.d/resource.d/Lustre

# Create the pristine source directory.
cd $RPM_BUILD_DIR/lustre-%{version}
mkdir -p $RPM_BUILD_ROOT%{_prefix}/src
rm -f lustre-source
ln -s $RPM_BUILD_ROOT%{_prefix}/src lustre-source
make distdir distdir=lustre-source/lustre-%{version}
chmod -R go-w lustre-source/lustre-%{version}
# fc18 needs 'x' permission for library files
find $RPM_BUILD_ROOT -name '*.so' | xargs chmod +x

cat >lustre.files <<EOF
%attr(-, root, root) %{?rootdir}/sbin/mount.lustre
%attr(-, root, root) %{_sbindir}/*
%attr(-, root, root) %{_bindir}/*
%attr(-, root, root) %{_libdir}/libptlctl.a
%attr(-, root, root) %{_libdir}/liblustreapi.a
%attr(-, root, root) %{_libdir}/liblustreapi.so
%attr(-, root, root) %{_mandir}/man?/*
%attr(-, root, root) %{_datadir}/lustre
%attr(-, root, root) %{_includedir}/lustre
%attr(-, root, root) %{_includedir}/libcfs
%attr(-, root, root) %{_libexecdir}/lustre/lc_common
%attr(-, root, root) %{_sysconfdir}/udev/rules.d/99-lustre.rules
%attr(-, root, root) %{_sysconfdir}/init.d/lnet
%attr(-, root, root) %{_sysconfdir}/init.d/lustre
%attr(-, root, root) %config(noreplace) %{_sysconfdir}/ldev.conf
%attr(-, root, root) %{_sysconfdir}/sysconfig/lustre
%attr(-, root, root) %{_libexecdir}/lustre/haconfig
%attr(-, root, root) %{_sysconfdir}/ha.d/resource.d/Lustre.ha_v2
%attr(-, root, root) %{_sysconfdir}/ha.d/resource.d/Lustre
EOF

if [ -f $RPM_BUILD_ROOT%{_libdir}/libcfsutil.a ] ; then
  echo '%attr(-, root, root) %{_libdir}/libcfsutil.a' >>lustre.files
fi

if [ -f $RPM_BUILD_ROOT%{_libdir}/liblustre.so ] ; then
  echo '%attr(-, root, root) %{_libdir}/liblustre.a' >>lustre.files
  echo '%attr(-, root, root) %{_libdir}/liblustre.so' >>lustre.files
fi

if [ -f $RPM_BUILD_ROOT%{_libdir}/libiam.a ] ; then
  echo '%attr(-, root, root) %{_libdir}/libiam.a' >>lustre.files
fi

if [ -d $RPM_BUILD_ROOT%{_libdir}/lustre/snmp ] ; then
  echo '%attr(-, root, root) %{_libdir}/lustre/snmp' >>lustre.files
  echo '%attr(-, root, root) %{_datadir}/lustre/snmp/mibs' >>lustre.files
fi

# Have universal lustre headers
if [ -f $RPM_BUILD_DIR/lustre-%{version}/lustre/include/lustre/lustre_idl.h ] ; then
  echo '%attr(-, root, root) %{_includedir}/linux/lustre_user.h' >>lustre.files
else
  echo '%attr(-, root, root) %{_includedir}/linux/lustre_idl.h' >>lustre.files
fi

if [ -f $RPM_BUILD_DIR/lustre-%{version}/lustre/include/linux/lustre_types.h ] ; then
  echo '%attr(-, root, root) %{_includedir}/linux/lustre_types.h' >>lustre.files
fi

%if %{build_lustre_tests}
echo '%attr(-, root, root) %{_libdir}/lustre/tests/*' >lustre-tests.files
%if %{build_lustre_modules}
echo '%attr(-, root, root) %{?rootdir}/lib/modules/%{kversion}/updates/kernel/fs/lustre/llog_test.*' >>lustre-tests.files
%endif
if [ -d $RPM_BUILD_ROOT%{_libdir}/lustre/liblustre/tests ] ; then
  echo '%attr(-, root, root) %{_libdir}/lustre/liblustre/tests/*' >>lustre-tests.files
fi
%endif

%if %{defined cross_path}
%if %{defined rpm_post_base}
POST_SCRIPT=$RPM_BUILD_DIR/lustre-%{version}/%{post_script}
if [ -f $POST_SCRIPT ]; then
	cp -f $POST_SCRIPT $RPM_BUILD_ROOT/%{rpm_post_base}.sh
	echo '%attr(0555, root, root) %{rpm_post_base}.sh' >>lustre.files
	cp -f $POST_SCRIPT $RPM_BUILD_ROOT/%{rpm_post_base}-modules.sh
%if %{build_lustre_osd_ldiskfs}
	cp -f $POST_SCRIPT $RPM_BUILD_ROOT/%{rpm_post_base}-osd-ldiskfs.sh
%endif
%if %{build_lustre_osd_zfs}
	cp -f $POST_SCRIPT $RPM_BUILD_ROOT/%{rpm_post_base}-osd-zfs.sh
%endif
%if %{build_lustre_tests}
	cp -f $POST_SCRIPT $RPM_BUILD_ROOT/%{rpm_post_base}-tests.sh
	echo '%attr(0555, root, root) %{rpm_post_base}-tests.sh' >>lustre-tests.files
%endif
fi
%endif
%else
# mark modules executable for find-debuginfo.sh
find $RPM_BUILD_ROOT%{?rootdir}/lib/modules/%{kversion}/updates -name "*.ko" -type f | \
	xargs --no-run-if-empty chmod u+x
%endif

%files -f lustre.files

%if %{build_lustre_modules}
%files modules
%attr(-, root, root) %{?rootdir}/lib/modules/%{kversion}/updates/*
%if %{build_lustre_tests}
%exclude %{?rootdir}/lib/modules/%{kversion}/updates/kernel/fs/lustre/llog_test.ko
%endif
%if %{build_lustre_osd_ldiskfs}
%exclude %{?rootdir}/lib/modules/%{kversion}/updates/kernel/fs/lustre/osd_ldiskfs.ko
%endif
%if %{build_lustre_osd_zfs}
%exclude %{?rootdir}/lib/modules/%{kversion}/updates/kernel/fs/lustre/osd_zfs.ko
%endif
%if %{defined rpm_post_base}
%attr(0555, root, root) %{rpm_post_base}-modules.sh
%endif
%attr(-, root, root) %doc COPYING
%attr(-, root, root) %doc ChangeLog-lustre
%attr(-, root, root) %doc ChangeLog-lnet

%if %{build_lustre_osd_ldiskfs}
%files osd-ldiskfs
%attr(-, root, root) %{?rootdir}/lib/modules/%{kversion}/updates/kernel/fs/lustre/osd_ldiskfs.ko
%if %{defined rpm_post_base}
%attr(0555, root, root) %{rpm_post_base}-osd-ldiskfs.sh
%endif
%endif

%if %{build_lustre_osd_zfs}
%files osd-zfs
%attr(-, root, root) %{?rootdir}/lib/modules/%{kversion}/updates/kernel/fs/lustre/osd_zfs.ko
%if %{defined rpm_post_base}
%attr(0555, root, root) %{rpm_post_base}-osd-zfs.sh
%endif
%endif
%endif

%files source
%attr(-, root, root) %{_prefix}/src/lustre-%{version}

# uncomment these lines to enable deps packages
# %files deps-sles
# %files deps-rhel

%if %{build_lustre_tests}
%files tests -f lustre-tests.files
%endif

%if %{defined rpm_post_base}
%post
if [ -x %{rpm_post_base}.sh ]; then
	%{rpm_post_base}.sh %{cross_path} create
fi

%preun
if [ -x %{rpm_post_base}.sh ]; then
	%{rpm_post_base}.sh %{cross_path} remove
fi
%endif

%if %{build_lustre_modules}
%post modules
%if %{defined rpm_post_base}
if [ -x %{rpm_post_base}-modules.sh ]; then
	%{rpm_post_base}-modules.sh %{cross_path} create
fi
%else
if [ -f /boot/System.map-%{kversion} ]; then
	depmod -ae -F /boot/System.map-%{kversion} %{kversion} || exit 0
else
	depmod -ae %{kversion} || exit 0
fi

MODULES_RPM_NAME=$(rpm -q %{name}-modules | grep "%{version}-%{release}")
# "weak modules" support
# Suse
if [ -x /usr/lib/module-init-tools/weak-modules ]; then
    rpm -ql $MODULES_RPM_NAME | grep '\.ko$' |
        /usr/lib/module-init-tools/weak-modules --add-modules
fi
# RedHat
if [ -x /sbin/weak-modules ]; then
    rpm -ql $MODULES_RPM_NAME | grep '\.ko$' |
        /sbin/weak-modules --add-modules
fi

# If the kernel was built to reject unsupported modules (e.g. not a Lustre
# kernel), and this hasn't been overridden in /etc/modprobe.d yet, then
# print a warning so that users are aware of this issue.
if sysctl kernel.unsupported >/dev/null 2>&1 &&
   [ "$(sysctl -n kernel.unsupported 2>/dev/null)" = "0" ] &&
    ! modprobe -c | grep -q "^allow_unsupported_modules[ \t]1" ; then
     echo "
     warning: the Lustre modules are not supported by Novell. To use Lustre
              on this system, you should put

     allow_unsupported_modules 1

     into /etc/modprobe.d/unsupported_modules"
fi
%endif

%if %{build_lustre_osd_ldiskfs}
%post osd-ldiskfs
%if %{defined rpm_post_base}
if [ -x %{rpm_post_base}-osd-ldiskfs.sh ]; then
	%{rpm_post_base}-osd-ldiskfs.sh %{cross_path} create
fi
%else
if [ -f /boot/System.map-%{kversion} ]; then
       depmod -ae -F /boot/System.map-%{kversion} %{kversion} || exit 0
else
       depmod -ae %{kversion} || exit 0
fi

OSD_LDISKFS_RPM_NAME=$(rpm -q %{name}-osd-ldiskfs | grep "%{version}-%{release}")
# "weak modules" support
# Suse
if [ -x /usr/lib/module-init-tools/weak-modules ]; then
    rpm -ql $OSD_LDISKFS_RPM_NAME | grep '\.ko$' |
        /usr/lib/module-init-tools/weak-modules --add-modules
fi
# RedHat
if [ -x /sbin/weak-modules ]; then
    rpm -ql $OSD_LDISKFS_RPM_NAME | grep '\.ko$' |
        /sbin/weak-modules --add-modules
fi

# If the kernel was built to reject unsupported modules (e.g. not a Lustre
# kernel), and this hasn't been overridden in /etc/modprobe.d yet, then
# print a warning so that users are aware of this issue.
if sysctl kernel.unsupported >/dev/null 2>&1 &&
   [ "$(sysctl -n kernel.unsupported 2>/dev/null)" = "0" ] &&
    ! modprobe -c | grep -q "^allow_unsupported_modules[ \t]1" ; then
     echo "
     warning: the Lustre modules are not supported by Novell. To use Lustre
              on this system, you should put

     allow_unsupported_modules 1

     into /etc/modprobe.d/unsupported_modules"
fi
%endif
%endif

%if %{build_lustre_osd_zfs}
%post osd-zfs
%if %{defined rpm_post_base}
if [ -x %{rpm_post_base}-osd-zfs.sh ]; then
	%{rpm_post_base}-osd-zfs.sh %{cross_path} create
fi
%else
if [ -f /boot/System.map-%{kversion} ]; then
       depmod -ae -F /boot/System.map-%{kversion} %{kversion} || exit 0
else
       depmod -ae %{kversion} || exit 0
fi

OSD_ZFS_RPM_NAME=$(rpm -q %{name}-osd-zfs | grep "%{version}-%{release}")
# "weak modules" support
# Suse
if [ -x /usr/lib/module-init-tools/weak-modules ]; then
    rpm -ql $OSD_ZFS_RPM_NAME | grep '\.ko$' |
        /usr/lib/module-init-tools/weak-modules --add-modules
fi
# RedHat
if [ -x /sbin/weak-modules ]; then
    rpm -ql $OSD_ZFS_RPM_NAME | grep '\.ko$' |
        /sbin/weak-modules --add-modules
fi

# If the kernel was built to reject unsupported modules (e.g. not a Lustre
# kernel), and this hasn't been overridden in /etc/modprobe.d yet, then
# print a warning so that users are aware of this issue.
if sysctl kernel.unsupported >/dev/null 2>&1 &&
   [ "$(sysctl -n kernel.unsupported 2>/dev/null)" = "0" ] &&
    ! modprobe -c | grep -q "^allow_unsupported_modules[ \t]1" ; then
     echo "
     warning: the Lustre modules are not supported by Novell. To use Lustre
              on this system, you should put

     allow_unsupported_modules 1

     into /etc/modprobe.d/unsupported_modules"
fi
%endif
%endif

%preun modules
%if %{defined rpm_post_base}
if [ -x %{rpm_post_base}-modules.sh ]; then
	%{rpm_post_base}-modules.sh %{cross_path} remove
fi
%else
MODULES_RPM_NAME=$(rpm -q %{name}-modules | grep "%{version}-%{release}")
rpm -ql $MODULES_RPM_NAME | grep '\.ko$' > /var/run/%{name}-modules || true
%endif

%if %{build_lustre_osd_ldiskfs}
%preun osd-ldiskfs
%if %{defined rpm_post_base}
if [ -x %{rpm_post_base}-osd-ldiskfs.sh ]; then
	%{rpm_post_base}-osd-ldiskfs.sh %{cross_path} remove
fi
%else
OSD_LDISKFS_RPM_NAME=$(rpm -q %{name}-osd-ldiskfs | grep "%{version}-%{release}")
rpm -ql $OSD_LDISKFS_RPM_NAME | grep '\.ko$' > /var/run/%{name}-osd-ldiskfs || true
%endif
%endif

%if %{build_lustre_osd_zfs}
%preun osd-zfs
%if %{defined rpm_post_base}
if [ -x %{rpm_post_base}-osd-zfs.sh ]; then
	%{rpm_post_base}-osd-zfs.sh %{cross_path} remove
fi
%else
OSD_ZFS_RPM_NAME=$(rpm -q %{name}-osd-zfs | grep "%{version}-%{release}")
rpm -ql $OSD_ZFS_RPM_NAME | grep '\.ko$' > /var/run/%{name}-osd-zfs || true
%endif
%endif

%if %{undefined cross_path}
%postun modules
if [ -f /boot/System.map-%{kversion} ]; then
	depmod -ae -F /boot/System.map-%{kversion} %{kversion} || exit 0
else
	depmod -ae %{kversion} || exit 0
fi

# "weak modules" support
# Suse
if [ -x /usr/lib/module-init-tools/weak-modules ]; then
    cat /var/run/%{name}-modules |
        /usr/lib/module-init-tools/weak-modules --remove-modules
fi
# RedHat
if [ -x /sbin/weak-modules ]; then
    cat /var/run/%{name}-modules |
        /sbin/weak-modules --remove-modules
fi
rm /var/run/%{name}-modules

%if %{build_lustre_osd_ldiskfs}
%postun osd-ldiskfs
if [ -f /boot/System.map-%{kversion} ]; then
       depmod -ae -F /boot/System.map-%{kversion} %{kversion} || exit 0
else
       depmod -ae %{kversion} || exit 0
fi

# "weak modules" support
# Suse
if [ -x /usr/lib/module-init-tools/weak-modules ]; then
    cat /var/run/%{name}-osd-ldiskfs |
        /usr/lib/module-init-tools/weak-modules --remove-modules
fi
# RedHat
if [ -x /sbin/weak-modules ]; then
    cat /var/run/%{name}-osd-ldiskfs |
        /sbin/weak-modules --remove-modules
fi
rm /var/run/%{name}-osd-ldiskfs
%endif

%if %{build_lustre_osd_zfs}
%postun osd-zfs
if [ -f /boot/System.map-%{kversion} ]; then
       depmod -ae -F /boot/System.map-%{kversion} %{kversion} || exit 0
else
       depmod -ae %{kversion} || exit 0
fi

# "weak modules" support
# Suse
if [ -x /usr/lib/module-init-tools/weak-modules ]; then
    cat /var/run/%{name}-osd-zfs |
        /usr/lib/module-init-tools/weak-modules --remove-modules
fi
# RedHat
if [ -x /sbin/weak-modules ]; then
    cat /var/run/%{name}-osd-zfs |
        /sbin/weak-modules --remove-modules
fi
rm /var/run/%{name}-osd-zfs
%endif
%endif
%endif

%if %{build_lustre_tests}
%post tests
%if %{defined rpm_post_base}
if [ -x %{rpm_post_base}-tests.sh ]; then
	%{rpm_post_base}-tests.sh %{cross_path} create
fi

%preun tests
if [ -x %{rpm_post_base}-tests.sh ]; then
	%{rpm_post_base}-tests.sh %{cross_path} remove
fi
%else
if [ -f /boot/System.map-%{kversion} ]; then
	depmod -ae -F /boot/System.map-%{kversion} %{kversion} || exit 0
else
	depmod -ae %{kversion} || exit 0
fi

%postun tests
if [ -f /boot/System.map-%{kversion} ]; then
	depmod -ae -F /boot/System.map-%{kversion} %{kversion} || exit 0
else
	depmod -ae %{kversion} || exit 0
fi
%endif
%endif

%clean
rm -rf $RPM_BUILD_ROOT
