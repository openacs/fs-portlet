--
-- Creates the file-storage portlet
--
-- @author Arjun Sanyal(arjun@openforce.net)
-- @creation-date 2001-30-09
-- @version $Id$
--

declare
    ds_id portal_datasources.datasource_id%TYPE;
    foo integer;
begin
    ds_id := portal_datasource.new(
        name => 'fs_portlet',
        description => 'Displays the given folder_id'
    );

    --  the standard 4 params
    -- shadeable_p
    portal_datasource.set_def_param(
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 't',
        key => 'shadeable_p',
        value => 't'
    );

    -- hideable_p
    portal_datasource.set_def_param(
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 't',
        key => 'hideable_p',
        value => 't'
    );

    -- user_editable_p
    portal_datasource.set_def_param(
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 't',
        key => 'user_editable_p',
        value => 'f'
    );

    -- shaded_p
    portal_datasource.set_def_param(
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 't',
        key => 'shaded_p',
        value => 'f'
    );

    -- link_hideable_p
    portal_datasource.set_def_param(
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 't',
        key => 'link_hideable_p',
        value => 't'
    );

    -- fs-specific params
    portal_datasource.set_def_param(
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 'f',
        key => 'folder_id',
        value => ''
    );

    -- create the implementation
    foo := acs_sc_impl.new(
        'portal_datasource',
        'fs_portlet',
        'fs_portlet'
    );

    -- add all the hooks
    foo := acs_sc_impl.new_alias(
        'portal_datasource',
        'fs_portlet',
        'MyName',
        'fs_portlet::my_name',
        'TCL'
    );

    foo := acs_sc_impl.new_alias(
        'portal_datasource',
        'fs_portlet',
        'GetPrettyName',
        'fs_portlet::get_pretty_name',
        'TCL'
    );

    foo := acs_sc_impl.new_alias(
        'portal_datasource',
        'fs_portlet',
        'Link',
        'fs_portlet::link',
        'TCL'
    );

    foo := acs_sc_impl.new_alias(
        'portal_datasource',
        'fs_portlet',
        'AddSelfToPage',
        'fs_portlet::add_self_to_page',
        'TCL'
    );

    foo := acs_sc_impl.new_alias(
        'portal_datasource',
        'fs_portlet',
        'Show',
        'fs_portlet::show',
        'TCL'
    );

    foo := acs_sc_impl.new_alias(
        'portal_datasource',
        'fs_portlet',
        'Edit',
        'fs_portlet::edit',
        'TCL'
    );

    foo := acs_sc_impl.new_alias(
        'portal_datasource',
        'fs_portlet',
        'RemoveSelfFromPage',
        'fs_portlet::remove_self_from_page',
        'TCL'
    );

    foo := acs_sc_impl.new_alias(
        'portal_datasource',
        'fs_portlet',
        'MakeSelfAvailable',
        'fs_portlet::make_self_available',
        'TCL'
    );

    foo := acs_sc_impl.new_alias(
        'portal_datasource',
        'fs_portlet',
        'MakeSelfUnavailable',
        'fs_portlet::make_self_unavailable',
        'TCL'
    );

    -- Add the binding
    acs_sc_binding.new(
        contract_name => 'portal_datasource',
        impl_name => 'fs_portlet'
    );
end;
/
show errors
