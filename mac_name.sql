SELECT SUM(col1), SUM(col2), SUM(col3), SUM(col4), col5
FROM (
SELECT mac_name.firstname, mac_name.lastname, ntopv15.ethAddressString, mac_name.comp_os, ntopv15.created FROM mac_name LEFT OUTER JOIN ntopv15 ON mac_name.comp_mac = ntopv15.ethAddressString WHERE ntopv15.ipv4BytesRcvd > 100000 AND ntopv15.created > DATE_SUB(NOW(), INTERVAL 6 HOUR)

SELECT null as firstname, null as lastname, ntopv15.ethAddressString as MAC, null as OS, ntopv15.created as created FROM ntopv15 WHERE (ntopv15.ipv4BytesRcvd > 100000 AND ntopv15.created > DATE_SUB(NOW(), INTERVAL 6 HOUR) AND NOT EXISTS (SELECT comp_mac FROM mac_name WHERE mac_name.comp_mac = ntopv15.ethAddressString))
) derivedTable
GROUP BY col5;


SELECT firstname, lastname, MAC, OS, created FROM (
SELECT mac_name.firstname as firstname, mac_name.lastname as lastname, ntopv15.ethAddressString as MAC, mac_name.comp2_os as OS, ntopv15.created as created FROM mac_name LEFT OUTER JOIN ntopv15 ON mac_name.comp2_mac = ntopv15.ethAddressString WHERE ntopv15.ipv4BytesRcvd > 100000 AND ntopv15.created > DATE_SUB(NOW(), INTERVAL 6 HOUR)
UNION ALL
SELECT mac_name.firstname as firstname, mac_name.lastname as lastname, ntopv15.ethAddressString as MAC, mac_name.phone_os as OS, ntopv15.created as created FROM mac_name LEFT OUTER JOIN ntopv15 ON mac_name.phone_mac = ntopv15.ethAddressString WHERE ntopv15.ipv4BytesRcvd > 100000 AND ntopv15.created > DATE_SUB(NOW(), INTERVAL 6 HOUR)
UNION ALL
SELECT mac_name.firstname as firstname, mac_name.lastname as lastname, ntopv15.ethAddressString as MAC, mac_name.comp_os as OS, ntopv15.created as created FROM mac_name LEFT OUTER JOIN ntopv15 ON mac_name.comp_mac = ntopv15.ethAddressString WHERE ntopv15.ipv4BytesRcvd > 100000 AND ntopv15.created > DATE_SUB(NOW(), INTERVAL 6 HOUR)
UNION ALL
SELECT null as firstname, null as lastname, ntopv15.ethAddressString as MAC, null as OS, ntopv15.created as created FROM ntopv15 WHERE (ntopv15.ipv4BytesRcvd > 100000 AND ntopv15.created > DATE_SUB(NOW(), INTERVAL 6 HOUR) AND NOT EXISTS (SELECT comp_mac FROM mac_name WHERE mac_name.comp_mac = ntopv15.ethAddressString) AND NOT EXISTS (SELECT comp2_mac FROM mac_name WHERE mac_name.comp2_mac = ntopv15.ethAddressString) AND NOT EXISTS (SELECT phone_mac FROM mac_name WHERE mac_name.phone_mac = ntopv15.ethAddressString))
) as tmp
ORDER BY created ASC;

