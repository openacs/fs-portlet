--
--  Copyright (C) 2001, 2002 OpenForce, Inc.
--
--  This file is part of dotLRN.
--
--  dotLRN is free software; you can redistribute it and/or modify it under the
--  terms of the GNU General Public License as published by the Free Software
--  Foundation; either version 2 of the License, or (at your option) any later
--  version.
--
--  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
--  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
--  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
--  details.
--

--
-- Creates the file-storage portlet
--
-- @author Arjun Sanyal(arjun@openforce.net)
-- @creation-date 2001-30-09
-- @version $Id$
--

@@ fs-contents-portlet-create.sql

declare
    ds_id portal_datasources.datasource_id%TYPE;
    foo integer;
begin

    ds_id := portal_datasource.new(
        name => 'fs_portlet',
        description => 'Displays the given folder_id'
    );

    portal_datasource.set_def_param(
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 't',
        key => 'shadeable_p',
        value => 't'
    );

    portal_datasource.set_def_param(
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 't',
        key => 'hideable_p',
        value => 't'
    );

    portal_datasource.set_def_param(
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 't',
        key => 'user_editable_p',
        value => 'f'
    );

    portal_datasource.set_def_param(
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 't',
        key => 'shaded_p',
        value => 'f'
    );

    portal_datasource.set_def_param(
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 't',
        key => 'link_hideable_p',
        value => 't'
    );

    portal_datasource.set_def_param(
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 'f',
        key => 'scoped_p',
        value => 't'
    );

    portal_datasource.set_def_param(
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 'f',
        key => 'folder_id',
        value => ''
    );

    portal_datasource.set_def_param(
        datasource_id => ds_id,
        config_required_p => 't',
        configured_p => 'f',
        key => 'contents_url',
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
        'GetMyName',
        'fs_portlet::get_my_name',
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

    -- Add the binding
    acs_sc_binding.new(
        contract_name => 'portal_datasource',
        impl_name => 'fs_portlet'
    );

end;
/
show errors
