/*
 * datimetcpsrv.cpp
 *
 *  Created on: Aug 28, 2016
 *      Author: mercury
 */

#include "unp.h"

int main(int argc, char** argv)
{
	int sockfd;
	int connfd;
	socklen_t len;
	size_t str_len;
	char buf[1024+1];
	time_t tm;
	struct sockaddr_in servaddr, cliaddr;
	int ret;

	sockfd = socket(AF_INET, SOCK_STREAM, 0);
	memset(&servaddr, 0, sizeof(servaddr));
	servaddr.sin_family = AF_INET;
	servaddr.sin_port = htons(1300);
	servaddr.sin_addr.s_addr= htonl(INADDR_ANY);

	ret = bind(sockfd, (struct sockaddr*)&servaddr, sizeof(servaddr));
	if (ret == -1) {
		perror(NULL);
	}
	ret = listen(sockfd, 64);

	len = sizeof(cliaddr);
	while (true)
	{
		connfd = accept(sockfd, (struct sockaddr*)&cliaddr, &len);
		tm = time(NULL);
		strcpy(buf, ctime(&tm));
		str_len = strlen(buf);
		write(connfd, buf, str_len);
		close(connfd);
	}

	return 0;
}


