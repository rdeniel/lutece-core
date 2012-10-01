INSERT INTO core_user_parameter VALUES ('force_change_password_reinit', 'false');
INSERT INTO core_user_parameter VALUES ('password_minimum_length', '8');
INSERT INTO core_user_parameter VALUES ('password_format', 'false');
INSERT INTO core_user_parameter VALUES ('password_history_size', '');
INSERT INTO core_user_parameter VALUES ('maximum_number_password_change', '');
INSERT INTO core_user_parameter VALUES ('tsw_size_password_change', '');
INSERT INTO core_user_parameter VALUES ('use_advanced_security_parameters', '');
INSERT INTO core_user_parameter VALUES ('account_life_time', '12');
INSERT INTO core_user_parameter VALUES ('time_before_alert_account', '30');
INSERT INTO core_user_parameter VALUES ('nb_alert_account', '2');
INSERT INTO core_user_parameter VALUES ('time_between_alerts_account', '10');
INSERT INTO core_user_parameter VALUES ('access_failures_max', '3');
INSERT INTO core_user_parameter VALUES ('access_failures_interval', '10');
INSERT INTO core_user_parameter VALUES ('expired_alert_mail_sender', 'lutece@nowhere.com');
INSERT INTO core_user_parameter VALUES ('expired_alert_mail_subject', 'Votre compte a expiré');
INSERT INTO core_user_parameter VALUES ('first_alert_mail_sender', 'lutece@nowhere.com');
INSERT INTO core_user_parameter VALUES ('first_alert_mail_subject', 'Votre compte va bientot expirer');
INSERT INTO core_user_parameter VALUES ('other_alert_mail_sender', 'lutece@nowhere.com');
INSERT INTO core_user_parameter VALUES ('other_alert_mail_subject', 'Votre compte va bientot expirer');
INSERT INTO core_user_parameter VALUES ('account_reactivated_mail_sender', 'lutece@nowhere.com');
INSERT INTO core_user_parameter VALUES ('account_reactivated_mail_subject', 'Votre compte a bien été réactivé');

INSERT INTO core_datastore VALUES ('core_banned_domain_names', 'yopmail.com');

DROP TABLE IF EXISTS core_template;
CREATE TABLE core_template (
  template_name VARCHAR(100) NOT NULL,
  template_value LONG VARCHAR NULL,
  PRIMARY KEY (template_name)
  );
  
ALTER TABLE core_admin_user ADD COLUMN password_max_valid_date TIMESTAMP NULL ;
ALTER TABLE core_admin_user ADD COLUMN account_max_valid_date BIGINT NULL ;
ALTER TABLE core_admin_user ADD COLUMN nb_alerts_sent INTEGER DEFAULT 0 NOT NULL;
ALTER TABLE core_admin_user ADD COLUMN last_login TIMESTAMP DEFAULT '1980-01-01 00:00:00';
ALTER TABLE core_attribute ADD COLUMN anonymize SMALLINT DEFAULT NULL ;
ALTER TABLE core_portlet ADD COLUMN device_display_flags int default 15 NOT NULL;

DROP TABLE IF EXISTS core_user_password_history;
CREATE  TABLE core_user_password_history (
  id_user INT NOT NULL ,
  password VARCHAR(100) NOT NULL ,
  date_password_change TIMESTAMP NOT NULL DEFAULT NOW() ,
  PRIMARY KEY (id_user, date_password_change)
  );
  
DROP TABLE IF EXISTS core_admin_user_anonymize_field;
CREATE  TABLE core_admin_user_anonymize_field (
  field_name VARCHAR(100) NOT NULL ,
  anonymize SMALLINT NOT NULL ,
  PRIMARY KEY (field_name)
  );

INSERT INTO core_admin_user_anonymize_field (field_name, anonymize) VALUES ('access_code', 1);
INSERT INTO core_admin_user_anonymize_field (field_name, anonymize) VALUES ('last_name', 1);
INSERT INTO core_admin_user_anonymize_field (field_name, anonymize) VALUES ('first_name', 1);
INSERT INTO core_admin_user_anonymize_field (field_name, anonymize) VALUES ('email', 1);


INSERT INTO core_template VALUES ('core_first_alert_mail', 'Bonjour ${first_name} ! Votre compte utilisateur arrive à expiration. Pour prolonger sa validité, veuillez <a href="${url}">cliquer ici</a>.</br>Si vous ne le faites pas avant le ${date_valid}, il sera désactivé.');
INSERT INTO core_template VALUES ('core_expiration_mail', 'Bonjour ${first_name} ! Votre compte a expiré. Vous ne pourrez plus vous connecter avec, et les données vous concernant ont été anonymisées');
INSERT INTO core_template VALUES ('core_other_alert_mail', 'Bonjour ${first_name} ! Votre compte utilisateur arrive à expiration. Pour prolonger sa validité, veuillez <a href="${url}">cliquer ici</a>.</br>Si vous ne le faites pas avant le ${date_valid}, il sera désactivé.');
INSERT INTO core_template VALUES ('core_account_reactivated_mail', 'Bonjour ${first_name} ! Votre compte utilisateur a bien été réactivé. Il est désormais valable jusqu''au ${date_valid}.');
--
-- UPDATE of email size to 256 for respecting WSSO constraints 
--
ALTER TABLE core_admin_user MODIFY email  VARCHAR(256) default '' NOT NULL; 

INSERT INTO core_admin_right VALUES ('CORE_XSL_EXPORT_MANAGEMENT', 'portal.xsl.adminFeature.xsl_export_management.name', 2, 'jsp/admin/xsl/ManageXslExport.jsp', 'portal.xsl.adminFeature.xsl_export_management.description', 1, NULL, 'SYSTEM', NULL, NULL, 10);
INSERT INTO core_user_right VALUES ('CORE_XSL_EXPORT_MANAGEMENT', 1);
INSERT INTO core_admin_role_resource VALUES (164,'all_site_manager', 'XSL_EXPORT', '*', '*');

DROP TABLE IF EXISTS core_xsl_export;
CREATE TABLE core_xsl_export (
  id_xsl_export INT NOT NULL,
  title VARCHAR(255) DEFAULT NULL,
  description VARCHAR(255) DEFAULT NULL ,
  extension VARCHAR(255) DEFAULT NULL,
  id_file INT DEFAULT NULL,
  PRIMARY KEY  (id_xsl_export)
);

REPLACE INTO core_stylesheet (id_stylesheet, description, file_name, source) VALUES (253,'Pages filles - Arborescence','menu_tree.xsl',0x3C3F786D6C2076657273696F6E3D22312E30223F3E0D0A3C78736C3A7374796C6573686565742076657273696F6E3D22312E302220786D6C6E733A78736C3D22687474703A2F2F7777772E77332E6F72672F313939392F58534C2F5472616E73666F726D223E0D0A0D0A3C78736C3A706172616D206E616D653D22736974652D70617468222073656C6563743D22736974652D7061746822202F3E0D0A0D0A3C78736C3A74656D706C617465206D617463683D226D656E752D6C697374223E0D0A093C78736C3A7661726961626C65206E616D653D226D656E752D6C697374222073656C6563743D226D656E7522202F3E0D0A0D0A093C73637269707420747970653D22746578742F6A617661736372697074223E0D0A09092428646F63756D656E74292E72656164792866756E6374696F6E28297B0D0A090909242822237472656522292E7472656576696577287B0D0A09090909616E696D617465643A202266617374222C0D0A09090909636F6C6C61707365643A2066616C73652C0D0A09090909756E697175653A20747275652C0D0A09090909706572736973743A2022636F6F6B6965220D0A0909097D293B0D0A09090D0A09097D293B0D0A093C2F7363726970743E202020200D0A090D0A093C212D2D204D656E752054726565202D2D3E2020202020200D0A093C78736C3A696620746573743D226E6F7428737472696E67286D656E75293D272729223E0D0A09202020203C78736C3A746578742064697361626C652D6F75747075742D6573636170696E673D22796573223E0909202020200D0A2020202020202020202020203C64697620636C6173733D227472656534223E09090D0A0909093C68323E26233136303B3C2F68323E0D0A0909093C756C2069643D22747265652220636C6173733D227472656534223E0D0A202020202020202020202020202020203C78736C3A6170706C792D74656D706C617465732073656C6563743D226D656E7522202F3E20202020202020200D0A0909093C2F756C3E090D0A0909093C2F6469763E0D0A09092009203C6272202F3E0D0A09093C2F78736C3A746578743E200D0A093C2F78736C3A69663E0D0A3C2F78736C3A74656D706C6174653E0D0A0D0A0D0A3C78736C3A74656D706C617465206D617463683D226D656E75223E0D0A202020203C78736C3A7661726961626C65206E616D653D22696E646578223E0D0A20202020093C78736C3A6E756D626572206C6576656C3D2273696E676C65222076616C75653D22706F736974696F6E282922202F3E0D0A202020203C2F78736C3A7661726961626C653E0D0A09093C6C693E0D0A202020203C212D2D3C78736C3A696620746573743D2224696E64657820266C743B2037223E2D2D3E20202020202020200D0A202020202020202020203C6120687265663D227B24736974652D706174687D3F706167655F69643D7B706167652D69647D22207461726765743D225F746F7022203E0D0A2020202020202020202020202020203C78736C3A76616C75652D6F662073656C6563743D22706167652D6E616D6522202F3E0D0A20202020202020202020203C2F613E092020200D0A09092020203C6272202F3E0D0A09092020203C78736C3A76616C75652D6F662073656C6563743D22706167652D6465736372697074696F6E22202F3E0D0A09092020203C212D2D3C78736C3A76616C75652D6F662073656C6563743D22706167652D6465736372697074696F6E22202F3E3C6272202F3E2D2D3E09092020200909090D0A0909093C78736C3A6170706C792D74656D706C617465732073656C6563743D227375626C6576656C2D6D656E752D6C69737422202F3E200D0A0909090D0A09093C2F6C693E20090D0A202020203C212D2D3C2F78736C3A69663E2D2D3E0D0A09090D0A3C2F78736C3A74656D706C6174653E0D0A0D0A3C78736C3A74656D706C617465206D617463683D227375626C6576656C2D6D656E752D6C69737422203E200D0A090D0A093C78736C3A6170706C792D74656D706C617465732073656C6563743D227375626C6576656C2D6D656E7522202F3E200920202020090D0A0D0A3C2F78736C3A74656D706C6174653E0D0A0D0A0D0A3C78736C3A74656D706C617465206D617463683D227375626C6576656C2D6D656E75223E0D0A2020203C78736C3A7661726961626C65206E616D653D22696E6465785F736F75735F6D656E75223E0D0A2020202020202020203C78736C3A6E756D626572206C6576656C3D2273696E676C65222076616C75653D22706F736974696F6E282922202F3E0D0A2020203C2F78736C3A7661726961626C653E0D0A0909203C756C203E0D0A0909093C6C693E0D0A3C212D2D093C7370616E3E202D2D3E0D0A090909093C6120687265663D227B24736974652D706174687D3F706167655F69643D7B706167652D69647D22207461726765743D225F746F70223E0D0A09090909093C78736C3A76616C75652D6F662073656C6563743D22706167652D6E616D6522202F3E0D0A090909093C2F613E0D0A0909093C2F6C693E0909090D0A09093C2F756C3E0D0A093C212D2D3C2F7370616E3E092D2D3E0D0A09090D0A2020200D0A3C2F78736C3A74656D706C6174653E0D0A0D0A3C2F78736C3A7374796C6573686565743E0D0A);
REPLACE INTO core_stylesheet (id_stylesheet, description, file_name, source) VALUES (215,'Chemin page','page_path.xsl',0x3C3F786D6C2076657273696F6E3D22312E30223F3E0D0A3C78736C3A7374796C6573686565742076657273696F6E3D22312E302220786D6C6E733A78736C3D22687474703A2F2F7777772E77332E6F72672F313939392F58534C2F5472616E73666F726D223E0D0A0D0A3C78736C3A706172616D206E616D653D22736974652D70617468222073656C6563743D22736974652D7061746822202F3E0D0A0D0A0D0A3C78736C3A74656D706C617465206D617463683D2270616765223E0D0A09093C78736C3A696620746573743D22706F736974696F6E2829213D6C61737428292D31223E0D0A0909093C6120687265663D227B24736974652D706174687D3F706167655F69643D7B706167652D69647D22207461726765743D225F746F70223E3C78736C3A76616C75652D6F662073656C6563743D22706167652D6E616D6522202F3E3C2F613E203E0D0A09093C2F78736C3A69663E0D0A09093C78736C3A696620746573743D22706F736974696F6E28293D6C61737428292D31223E0D0A0909093C78736C3A76616C75652D6F662073656C6563743D22706167652D6E616D6522202F3E0D0A09093C2F78736C3A69663E0D0A3C2F78736C3A74656D706C6174653E0D0A0D0A0D0A3C78736C3A74656D706C617465206D617463683D22706167655F6C696E6B223E0D0A09093C78736C3A696620746573743D22706F736974696F6E2829213D6C61737428292D31223E0D0A0909093C6120687265663D227B24736974652D706174687D3F7B706167652D75726C7D22207461726765743D225F746F70223E3C78736C3A76616C75652D6F662073656C6563743D22706167652D6E616D6522202F3E3C2F613E203E0D0A09093C2F78736C3A69663E0D0A09093C78736C3A696620746573743D22706F736974696F6E28293D6C61737428292D31223E0D0A0909093C78736C3A76616C75652D6F662073656C6563743D22706167652D6E616D6522202F3E0D0A09093C2F78736C3A69663E0D0A3C2F78736C3A74656D706C6174653E0D0A0D0A0D0A3C2F78736C3A7374796C6573686565743E);
REPLACE INTO core_stylesheet (id_stylesheet, description, file_name, source) VALUES (213,'Menu principal','menu_main.xsl',0x3C3F786D6C2076657273696F6E3D22312E30223F3E0D0A3C78736C3A7374796C6573686565742076657273696F6E3D22312E30220D0A09786D6C6E733A78736C3D22687474703A2F2F7777772E77332E6F72672F313939392F58534C2F5472616E73666F726D223E0D0A0D0A093C78736C3A706172616D206E616D653D22736974652D70617468222073656C6563743D22736974652D7061746822202F3E0D0A0D0A093C78736C3A74656D706C617465206D617463683D226D656E752D6C697374223E0D0A09093C78736C3A6170706C792D74656D706C617465732073656C6563743D226D656E7522202F3E0D0A093C2F78736C3A74656D706C6174653E0D0A0D0A093C78736C3A74656D706C617465206D617463683D226D656E75223E0D0A09093C6C693E0D0A0909093C6120687265663D227B24736974652D706174687D3F706167655F69643D7B706167652D69647D2220636C6173733D2266697273742D6C6576656C22207461726765743D225F746F70223E0D0A09090909093C78736C3A76616C75652D6F662073656C6563743D22706167652D6E616D6522202F3E0D0A0909093C2F613E0D0A09093C2F6C693E0D0A093C2F78736C3A74656D706C6174653E0D0A0D0A3C2F78736C3A7374796C6573686565743E0D0A0D0A);
REPLACE INTO core_stylesheet (id_stylesheet, description, file_name, source) VALUES (211,'Menu Init','menu_init.xsl',0x3C3F786D6C2076657273696F6E3D22312E30223F3E0D0A3C78736C3A7374796C6573686565742076657273696F6E3D22312E302220786D6C6E733A78736C3D22687474703A2F2F7777772E77332E6F72672F313939392F58534C2F5472616E73666F726D223E0D0A0D0A3C78736C3A706172616D206E616D653D22736974652D70617468222073656C6563743D22736974652D7061746822202F3E0D0A0D0A3C78736C3A74656D706C617465206D617463683D226D656E752D6C697374223E0D0A3C6272202F3E3C6272202F3E0D0A093C6469762069643D226D656E752D696E6974223E0D0A09093C6469762069643D226D656E752D696E69742D636F6E74656E74223E0D0A2020202020202020202020203C756C2069643D226D656E752D7665727469223E0D0A202020202020202020202020202020203C78736C3A6170706C792D74656D706C617465732073656C6563743D226D656E7522202F3E0D0A2020202020202020202020203C2F756C3E0D0A20202020202020203C2F6469763E0D0A20202020203C2F6469763E0D0A3C2F78736C3A74656D706C6174653E0D0A0D0A0D0A3C78736C3A74656D706C617465206D617463683D226D656E75223E0D0A202020203C78736C3A7661726961626C65206E616D653D22696E646578223E0D0A20202020093C78736C3A6E756D626572206C6576656C3D2273696E676C65222076616C75653D22706F736974696F6E282922202F3E0D0A202020203C2F78736C3A7661726961626C653E0D0A0D0A202020203C78736C3A696620746573743D2224696E646578202667743B2037223E0D0A20202020202020203C6C6920636C6173733D2266697273742D7665727469223E0D0A2020202020202020093C6120687265663D227B24736974652D706174687D3F706167655F69643D7B706167652D69647D22207461726765743D225F746F70223E0D0A2020202020202020202009093C78736C3A76616C75652D6F662073656C6563743D22706167652D6E616D6522202F3E0D0A0920202020202020203C2F613E0D0A2020202009202020203C78736C3A6170706C792D74656D706C617465732073656C6563743D227375626C6576656C2D6D656E752D6C69737422202F3E0D0A20202020202020203C2F6C693E0D0A2020203C2F78736C3A69663E0D0A3C2F78736C3A74656D706C6174653E0D0A0D0A3C78736C3A74656D706C617465206D617463683D227375626C6576656C2D6D656E752D6C69737422203E0D0A093C756C3E0D0A20202020093C6C6920636C6173733D226C6173742D7665727469223E0D0A090920093C78736C3A6170706C792D74656D706C617465732073656C6563743D227375626C6576656C2D6D656E7522202F3E0D0A2009202020203C2F6C693E0D0A202020203C2F756C3E0D0A3C2F78736C3A74656D706C6174653E0D0A0D0A3C78736C3A74656D706C617465206D617463683D227375626C6576656C2D6D656E75223E0D0A2020203C78736C3A7661726961626C65206E616D653D22696E6465785F736F75735F6D656E75223E0D0A2020202020202020203C78736C3A6E756D626572206C6576656C3D2273696E676C65222076616C75653D22706F736974696F6E282922202F3E0D0A2020203C2F78736C3A7661726961626C653E0D0A0D0A2020203C6120687265663D227B24736974652D706174687D3F706167655F69643D7B706167652D69647D22207461726765743D225F746F70223E0D0A09093C7370616E3E3C78736C3A76616C75652D6F662073656C6563743D22706167652D6E616D6522202F3E3C2F7370616E3E0D0A2020203C2F613E0D0A3C2F78736C3A74656D706C6174653E0D0A0D0A3C2F78736C3A7374796C6573686565743E0D0A);
REPLACE INTO core_stylesheet (id_stylesheet, description, file_name, source) VALUES (217,'Plan du site','site_map.xsl',0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D2249534F2D383835392D31223F3E0D0A3C78736C3A7374796C6573686565742076657273696F6E3D22312E302220786D6C6E733A78736C3D22687474703A2F2F7777772E77332E6F72672F313939392F58534C2F5472616E73666F726D223E0D0A0D0A3C78736C3A706172616D206E616D653D22736974652D70617468222073656C6563743D22736974652D7061746822202F3E0D0A0D0A0D0A3C78736C3A74656D706C617465206D617463683D22706167655B706167652D6C6576656C3D305D223E0D0A093C64697620636C6173733D227370616E2D31352070726570656E642D3120617070656E642D3120617070656E642D626F74746F6D223E0D0A09093C64697620636C6173733D22706F72746C6574202D6C75746563652D626F726465722D726164697573223E0D0A0909093C78736C3A6170706C792D74656D706C617465732073656C6563743D226368696C642D70616765732D6C69737422202F3E0D0A09093C2F6469763E0D0A093C2F6469763E0D0A093C6469762069643D22736964656261722220636C6173733D227370616E2D3620617070656E642D3120617070656E642D626F74746F6D206C617374223E0D0A09093C64697620636C6173733D22706F72746C6574202D6C75746563652D626F726465722D726164697573223E0D0A0909093C696D67207372633D22646F63756D656E743F69643D3726616D703B69645F6174747269627574653D35322220616C743D2262616E6E657222207469746C653D2262616E6E6572222F3E0D0A09090926233136303B0D0A09093C2F6469763E0D0A093C2F6469763E0D0A3C2F78736C3A74656D706C6174653E0D0A0D0A0D0A3C78736C3A74656D706C617465206D617463683D22706167655B706167652D6C6576656C3D315D22203E0D0A3C756C20636C6173733D22736974652D6D61702D6C6576656C2D6F6E65223E0D0A093C6C693E0D0A09093C6120687265663D227B24736974652D706174687D3F706167655F69643D7B706167652D69647D22207461726765743D225F746F70223E0D0A0909093C78736C3A76616C75652D6F662073656C6563743D22706167652D6E616D6522202F3E0D0A09093C2F613E0D0A09093C78736C3A6170706C792D74656D706C617465732073656C6563743D22706167652D6465736372697074696F6E22202F3E0D0A09093C78736C3A6170706C792D74656D706C617465732073656C6563743D22706167652D696D61676522202F3E0D0A09093C78736C3A6170706C792D74656D706C617465732073656C6563743D226368696C642D70616765732D6C69737422202F3E0D0A09202020203C78736C3A746578742064697361626C652D6F75747075742D6573636170696E673D22796573223E0D0A0909202020203C215B43444154415B3C64697620636C6173733D22636C656172223E26233136303B3C2F6469763E5D5D3E0D0A09202020203C2F78736C3A746578743E0D0A093C2F6C693E0D0A3C2F756C3E0D0A3C2F78736C3A74656D706C6174653E0D0A0D0A0D0A3C78736C3A74656D706C617465206D617463683D22706167655B706167652D6C6576656C3D325D22203E0D0A3C756C20636C6173733D22736974652D6D61702D6C6576656C2D74776F223E0D0A093C6C693E0D0A09093C6120687265663D227B24736974652D706174687D3F706167655F69643D7B706167652D69647D22207461726765743D225F746F70223E0D0A0909093C78736C3A76616C75652D6F662073656C6563743D22706167652D6E616D6522202F3E0D0A09093C2F613E0D0A09093C78736C3A6170706C792D74656D706C617465732073656C6563743D22706167652D6465736372697074696F6E22202F3E0D0A09093C78736C3A6170706C792D74656D706C617465732073656C6563743D226368696C642D70616765732D6C69737422202F3E0D0A093C2F6C693E0D0A3C2F756C3E0D0A3C2F78736C3A74656D706C6174653E0D0A0D0A0D0A3C78736C3A74656D706C617465206D617463683D22706167655B706167652D6C6576656C3E325D22203E0D0A3C756C20636C6173733D22736974652D6D61702D6C6576656C2D68696768657374223E0D0A093C6C693E0D0A09093C6120687265663D227B24736974652D706174687D3F706167655F69643D7B706167652D69647D22207461726765743D225F746F70223E0D0A0909093C78736C3A76616C75652D6F662073656C6563743D22706167652D6E616D6522202F3E0D0A09093C2F613E0D0A09093C78736C3A6170706C792D74656D706C617465732073656C6563743D22706167652D6465736372697074696F6E22202F3E0D0A09093C78736C3A6170706C792D74656D706C617465732073656C6563743D226368696C642D70616765732D6C69737422202F3E0D0A093C2F6C693E0D0A3C2F756C3E0D0A3C2F78736C3A74656D706C6174653E0D0A0D0A0D0A3C78736C3A74656D706C617465206D617463683D22706167652D6465736372697074696F6E223E0D0A093C6272202F3E3C78736C3A76616C75652D6F662073656C6563743D222E22202F3E0D0A3C2F78736C3A74656D706C6174653E0D0A0D0A0D0A3C78736C3A74656D706C617465206D617463683D226368696C642D70616765732D6C6973745B706167652D6C6576656C3D305D223E0D0A093C78736C3A696620746573743D22636F756E742870616765293E3022203E0D0A09093C78736C3A6170706C792D74656D706C617465732073656C6563743D227061676522202F3E0D0A202020203C2F78736C3A69663E0D0A3C2F78736C3A74656D706C6174653E0D0A0D0A0D0A3C78736C3A74656D706C617465206D617463683D226368696C642D70616765732D6C6973745B706167652D6C6576656C3D315D223E0D0A093C78736C3A696620746573743D22636F756E742870616765293E3022203E0D0A09093C78736C3A6170706C792D74656D706C617465732073656C6563743D227061676522202F3E0D0A202020203C2F78736C3A69663E0D0A3C2F78736C3A74656D706C6174653E0D0A0D0A0D0A3C78736C3A74656D706C617465206D617463683D226368696C642D70616765732D6C6973745B706167652D6C6576656C3D325D223E0D0A093C78736C3A696620746573743D22636F756E742870616765293E3022203E0D0A09093C78736C3A6170706C792D74656D706C617465732073656C6563743D227061676522202F3E0D0A202020203C2F78736C3A69663E0D0A3C2F78736C3A74656D706C6174653E0D0A0D0A3C78736C3A74656D706C617465206D617463683D226368696C642D70616765732D6C6973745B706167652D6C6576656C3E325D223E0D0A093C78736C3A696620746573743D22636F756E742870616765293E3022203E0D0A09093C78736C3A6170706C792D74656D706C617465732073656C6563743D227061676522202F3E0D0A202020203C2F78736C3A69663E0D0A3C2F78736C3A74656D706C6174653E0D0A0D0A0D0A3C78736C3A74656D706C617465206D617463683D22706167652D696D616765223E0D0A093C64697620636C6173733D226C6576656C2D6F6E652D696D616765223E0D0A20202020093C64697620636C6173733D22706F6C61726F6964223E0D0A09093C696D672020626F726465723D2230222077696474683D22383022206865696768743D22383022207372633D22696D616765732F6C6F63616C2F646174612F70616765732F7B2E7D2220616C743D2222202F3E0D0A2020202020202020203C2F6469763E0D0A093C2F646976203E0D0A3C2F78736C3A74656D706C6174653E0D0A0D0A0D0A3C2F78736C3A7374796C6573686565743E0D0A);
REPLACE INTO core_stylesheet (id_stylesheet, description, file_name, source) VALUES (279,'Plan du Site module d\'Administration','admin_site_map_admin.xsl',0x3C3F786D6C2076657273696F6E3D22312E30223F3E0D0A3C78736C3A7374796C6573686565742076657273696F6E3D22312E302220786D6C6E733A78736C3D22687474703A2F2F7777772E77332E6F72672F313939392F58534C2F5472616E73666F726D223E0D0A202020200D0A3C78736C3A706172616D206E616D653D22736974652D70617468222073656C6563743D22736974652D7061746822202F3E0D0A3C78736C3A7661726961626C65206E616D653D2263757272656E742D706167652D6964223E0D0A093C78736C3A76616C75652D6F662073656C6563743D2263757272656E742D706167652D696422202F3E0D0A3C2F78736C3A7661726961626C653E0D0A202020200D0A3C78736C3A74656D706C617465206D617463683D22706167655B706167652D6C6576656C3D305D223E200D0A3C6469762069643D22747265652220636C6173733D226A73747265652D64656661756C74223E0D0A093C6120687265663D227B24736974652D706174687D3F706167655F69643D7B706167652D69647D22207469746C653D227B706167652D6465736372697074696F6E7D22203E0D0A202020203C78736C3A76616C75652D6F662073656C6563743D22706167652D6E616D6522202F3E0D0A09093C78736C3A696620746573743D226E6F7428737472696E6728706167652D726F6C65293D276E6F6E652729223E200D0A20202020202020203C7374726F6E673E0D0A0909093C78736C3A746578742064697361626C652D6F75747075742D6573636170696E673D22796573223E2D20236931386E7B706F7274616C2E736974652E61646D696E5F706167652E74616241646D696E4D6170526F6C6552657365727665647D3C2F78736C3A746578743E0D0A2020202020202020202020203C78736C3A76616C75652D6F662073656C6563743D22706167652D726F6C6522202F3E0D0A20202020202020203C2F7374726F6E673E0D0A20202020202020203C2F78736C3A69663E2020202020202020202020200D0A202020203C2F613E0D0A202020203C756C3E0D0A09093C78736C3A6170706C792D74656D706C617465732073656C6563743D226368696C642D70616765732D6C69737422202F3E0D0A202020203C2F756C3E0D0A3C2F6469763E0D0A3C2F78736C3A74656D706C6174653E0D0A202020200D0A3C78736C3A74656D706C617465206D617463683D22706167655B706167652D6C6576656C3E305D22203E0D0A3C78736C3A7661726961626C65206E616D653D22696E646578223E0D0A093C78736C3A76616C75652D6F662073656C6563743D22706167652D696422202F3E0D0A3C2F78736C3A7661726961626C653E0D0A3C78736C3A7661726961626C65206E616D653D226465736372697074696F6E223E0D0A093C78736C3A76616C75652D6F662073656C6563743D22706167652D6465736372697074696F6E22202F3E0D0A3C2F78736C3A7661726961626C653E0D0A3C6C692069643D226E6F64652D7B24696E6465787D223E0D0A093C6120687265663D227B24736974652D706174687D3F706167655F69643D7B706167652D69647D22207469746C653D227B246465736372697074696F6E7D223E0D0A09093C7374726F6E673E3C78736C3A76616C75652D6F662073656C6563743D22706167652D696422202F3E3C2F7374726F6E673E26233136303B3C78736C3A76616C75652D6F662073656C6563743D22706167652D6E616D6522202F3E0D0A09093C78736C3A696620746573743D226E6F7428737472696E6728706167652D6465736372697074696F6E293D272729223E202D203C78736C3A76616C75652D6F662073656C6563743D22706167652D6465736372697074696F6E22202F3E3C2F78736C3A69663E0D0A09093C78736C3A696620746573743D226E6F7428737472696E6728706167652D726F6C65293D276E6F6E652729223E0D0A0909093C656D3E0D0A090909093C78736C3A746578742064697361626C652D6F75747075742D6573636170696E673D22796573223E236931386E7B706F7274616C2E736974652E61646D696E5F706167652E74616241646D696E4D6170526F6C6552657365727665647D3C2F78736C3A746578743E0D0A202020202020202020202020202020203C78736C3A76616C75652D6F662073656C6563743D22706167652D726F6C6522202F3E0D0A0909093C2F656D3E0D0A20202020202020203C2F78736C3A69663E0D0A202020203C2F613E0D0A093C78736C3A63686F6F73653E0D0A093C78736C3A7768656E20746573743D22636F756E74286368696C642D70616765732D6C6973742F2A293E30223E0D0A202020203C756C3E0D0A09093C78736C3A6170706C792D74656D706C617465732073656C6563743D226368696C642D70616765732D6C69737422202F3E0D0A202020203C2F756C3E0D0A202020203C2F78736C3A7768656E3E0D0A202020203C78736C3A6F74686572776973653E0D0A09093C78736C3A6170706C792D74656D706C617465732073656C6563743D226368696C642D70616765732D6C69737422202F3E0D0A093C2F78736C3A6F74686572776973653E0D0A202020203C2F78736C3A63686F6F73653E0D0A3C2F6C693E0D0A3C2F78736C3A74656D706C6174653E0D0A202020200D0A3C78736C3A74656D706C617465206D617463683D22706167652D6465736372697074696F6E223E0D0A093C78736C3A76616C75652D6F662073656C6563743D222E22202F3E0D0A3C2F78736C3A74656D706C6174653E0D0A202020200D0A3C78736C3A74656D706C617465206D617463683D226368696C642D70616765732D6C697374223E0D0A093C78736C3A6170706C792D74656D706C617465732073656C6563743D227061676522202F3E0D0A3C2F78736C3A74656D706C6174653E0D0A202020200D0A3C2F78736C3A7374796C6573686565743E);

