--
-- /fs-portlet/sql/oracle/fs-portlet-create.sql
--
-- Creates fs portlet
-- Copyright (C) 2001 OpenForce, Inc.
-- @author Arjun Sanyal (arjun@openforce.net)
-- @creation-date 2001-30-09
--
-- $Id$
--
-- This is free software distributed under the terms of the GNU Public
-- License version 2 or higher.  Full text of the license is available
-- from the GNU Project: http://www.fsf.org/copyleft/gpl.html

declare
  ds_id portal_datasources.datasource_id%TYPE;
begin
  ds_id := portal_datasource.new(
    name             => 'fs_portlet',
    description      => 'Displays the given folder_id'
  );

  --  the standard 4 params

  -- shadeable_p 
  portal_datasource.set_def_param (
	datasource_id => ds_id,
	config_required_p => 't',
	configured_p => 't',
	key => 'shadeable_p',
	value => 't'
);	


  -- hideable_p 
  portal_datasource.set_def_param (
	datasource_id => ds_id,
	config_required_p => 't',
	configured_p => 't',
	key => 'hideable_p',
	value => 't'
);	

  -- user_editable_p 
  portal_datasource.set_def_param (
	datasource_id => ds_id,
	config_required_p => 't',
	configured_p => 't',
	key => 'user_editable_p',
	value => 'f'
);	

  -- shaded_p 
  portal_datasource.set_def_param (
	datasource_id => ds_id,
	config_required_p => 't',
	configured_p => 't',
	key => 'shaded_p',
	value => 'f'
);	


  -- fs-specific params

  -- community_id must be configured
  portal_datasource.set_def_param (
	datasource_id => ds_id,
	config_required_p => 't',
	configured_p => 'f',
	key => 'community_id',
	value => ''
);


  portal_datasource.set_def_param (
	datasource_id => ds_id,
	config_required_p => 't',
	configured_p => 'f',
	key => 'folder_id',
	value => ''
);	


end;
/
show errors

declare
	foo integer;
begin
	-- create the implementation
	foo := acs_sc_impl.new (
		'portal_datasource',
		'fs_portlet',
		'fs_portlet'
	);

end;
/
show errors

declare
	foo integer;
begin
	-- add all the hooks
	foo := acs_sc_impl.new_alias (
	       'portal_datasource',
	       'fs_portlet',
	       'MyName',
	       'fs_portlet::my_name',
	       'TCL'
	);

	foo := acs_sc_impl.new_alias (
	       'portal_datasource',
	       'fs_portlet',
	       'GetPrettyName',
	       'fs_portlet::get_pretty_name',
	       'TCL'
	);

	foo := acs_sc_impl.new_alias (
	       'portal_datasource',
	       'fs_portlet',
	       'Link',
	       'fs_portlet::link',
	       'TCL'
	);

	foo := acs_sc_impl.new_alias (
	       'portal_datasource',
	       'fs_portlet',
	       'AddSelfToPage',
	       'fs_portlet::add_self_to_page',
	       'TCL'
	);

	foo := acs_sc_impl.new_alias (
	       'portal_datasource',
	       'fs_portlet',
	       'Show',
	       'fs_portlet::show',
	       'TCL'
	);

	foo := acs_sc_impl.new_alias (
	       'portal_datasource',
	       'fs_portlet',
	       'Edit',
	       'fs_portlet::edit',
	       'TCL'
	);

	foo := acs_sc_impl.new_alias (
	       'portal_datasource',
	       'fs_portlet',
	       'RemoveSelfFromPage',
	       'fs_portlet::remove_self_from_page',
	       'TCL'
	);

	foo := acs_sc_impl.new_alias (
	       'portal_datasource',
	       'fs_portlet',
	       'MakeSelfAvailable',
	       'fs_portlet::make_self_available',
	       'TCL'
	);

	foo := acs_sc_impl.new_alias (
	       'portal_datasource',
	       'fs_portlet',
	       'MakeSelfUnavailable',
	       'fs_portlet::make_self_unavailable',
	       'TCL'
	);
end;
/
show errors

declare
	foo integer;
begin
	-- Add the binding
	acs_sc_binding.new (
	    contract_name => 'portal_datasource',
	    impl_name => 'fs_portlet'
	);
end;
/
show errors

