ad_library {
    Automated tests for the fs-portlet package.

    @author Héctor Romojaro <hector.romojaro@gmail.com>
    @creation-date 2020-08-19
    @cvs-id $Id$
}

aa_register_case -procs {
        fs_admin_portlet::link
        fs_portlet::link
        fs_contents_portlet::link
    } -cats {
        api
        production_safe
    } fs_portlet_links {
        Test diverse link procs.
} {
    aa_equals "FS admin portlet link"       "[fs_admin_portlet::link]" ""
    aa_equals "FS portlet link"             "[fs_portlet::link]" ""
    aa_equals "FS contents portlet link"    "[fs_contents_portlet::link]" ""
}

# Local variables:
#    mode: tcl
#    tcl-indent-level: 4
#    indent-tabs-mode: nil
# End:
