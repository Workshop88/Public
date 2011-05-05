<?php
/*
  Plugin Name: W88 Member Site
  Plugin URI: http://www.workshop88.com/membersites/
  Description: Provides membership info for W88 members.
  Version: 1.0
  Author: Russ Lankenau & Jay Margalus
  Author URI: http://www.lunargiantstudios.com
  License: GPL2
*/


global $wpdb;

function membersites_doinit() {
   add_action('admin_menu', 'membersites_membership_panel');
   add_action('show_user_profile', 'membersites_display_user_data');
}

function membersites_activate() {

	global $wpdb;

	$tablename= $wpdb->prefix . "membership_payments";
	if($wpdb->get_var("show tables like '$tablename'") != $tablename)
	{
		$sql = "CREATE TABLE `" . $tablename . "` (
			`id` mediumint(9) NOT NULL AUTO_INCREMENT,
			`uid` mediumint(9) NOT NULL,
			`amt` int NOT NULL,
			`when` bigint(11) NOT NULL,
			UNIQUE KEY id (id)
			);";


		require_once(ABSPATH . 'wp-admin/includes/upgrade.php');
		dbDelta($sql);
	} else
	{
	}

}

function membersites_deactivate() { 
}

function membersites_get_all_users() {
	global $wpdb;
	$rtn = array();

	$wp_user_search = $wpdb->get_results("
			SELECT ID FROM $wpdb->users");

	foreach($wp_user_search as $id)
	{
		array_push($rtn, get_userdata($id->ID));
	}

	return $rtn;

}

function membersites_display_listing() {
	echo '<h2>Membership List</h2>';

	$all_users = membersites_get_all_users();
	echo '<table>';
	foreach($all_users as $user)
	{
		echo "<tr><th>{$user->user_firstname} {$user->user_lastname}</th>";
		echo "</tr>";
	}
	echo '</table>';
}

function membersites_display_user_data()
{
	echo '
		<h3>Membership Information</h3>
		<table class="form-table">
		<tr>
		<th scope="row">Membership Status</th>
		<td>
		<input type="radio" name="membership_status" value="non-member" checked />Non-Member<br/>
		<input type="radio" name="membership_status" value="supporting" />Supporting Member<br/>
		<input type="radio" name="membership_status" value="full" />Full Member<br/>
		</td>
		</tr>
		<tr>
		<th scope="row">Access Code</th>
		<td>
		8432 (This is just for testing, not correct.)
		</td>
		</tr>
		</table>
		';
}

function membersites_membership_panel() {
    add_submenu_page('users.php', "Member Status", "Membership", promote_users, 'membership_list', 'membersites_display_listing');
}

register_activation_hook(__FILE__, 'membersites_activate');
register_deactivation_hook(__FILE__, 'membersites_deactivate');
add_action("init", "membersites_doinit");
?>
