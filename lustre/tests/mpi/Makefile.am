# Lustre MPI test Makefile
AM_CPPFLAGS = $(LLCPPFLAGS) -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -DLUSTRE_UTILS
AM_CFLAGS = $(LLCFLAGS)
LIBCFS :=  $(top_builddir)/libcfs/libcfs/libcfs.a

CC = @MPICC_WRAPPER@

noinst_PROGRAMS = parallel_grouplock write_append_truncate createmany_mpi
noinst_PROGRAMS += mdsrate write_disjoint cascading_rw
testdir = $(libdir)/lustre/tests
test_SCRIPTS = $(noinst_PROGRAMS)

write_append_truncate_SOURCES=write_append_truncate.c
write_disjoint_SOURCES=write_disjoint.c
createmany_mpi_SOURCES=createmany-mpi.c
parallel_grouplock_SOURCES=parallel_grouplock.c lp_utils.c lp_utils.h
cascading_rw_SOURCES=cascading_rw.c lp_utils.c lp_utils.h
cascading_rw_LDADD=-L$(top_builddir)/lustre/utils -llustreapi
mdsrate_SOURCES=mdsrate.c
mdsrate_LDADD=-L$(top_builddir)/lustre/utils -llustreapi $(LIBCFS)
