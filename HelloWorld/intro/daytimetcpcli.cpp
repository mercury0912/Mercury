/*
 * daytimetcpcli.cpp
 *
 *  Created on: Aug 28, 2016
 *      Author: mercury
 */

#include "unp.h"

int main(int argc, char** argv)
{
	int sd;
	int n;
	struct sockaddr_in server_addr;
	char buffer[1024 + 1];

	if (argc != 2)
	{
		return 0;
	}

	sd = socket(AF_INET, SOCK_STREAM, 0);

	memset(&server_addr, 0, sizeof(server_addr));
	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(1300);
	inet_pton(AF_INET, argv[1], &server_addr.sin_addr);
	connect(sd, (struct sockaddr*)&server_addr, sizeof(server_addr));

	while ( (n = read(sd, buffer, 1024)) > 0)
	{
		buffer[n] = '\0';
		fputs(buffer, stdout);
	}

	return 0;
}


