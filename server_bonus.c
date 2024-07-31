/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server_bonus.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: jzubizar <jzubizar@student.42urduliz.co    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/08/04 15:40:39 by josu              #+#    #+#             */
/*   Updated: 2023/08/07 12:41:44 by jzubizar         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include"minitalk_bonus.h"

int	g_rec = -1;

char	ft_receive_char(void)
{
	int		i;
	char	ch;

	i = 0;
	ch = 0;
	while (1)
	{
		while (g_rec == -1)
			continue ;
		if (g_rec == 1)
			ch = ch * 2 + 1;
		else if (g_rec == 2)
			ch = ch * 2;
		g_rec = -1;
		if (++i == 8)
			return (ch);
	}
}

void	ft_handle_usr(int sig, siginfo_t *info, void *con)
{
	(void)con;
	if (sig == SIGUSR1)
		g_rec = 1;
	else if (sig == SIGUSR2)
		g_rec = 2;
	kill(info->si_pid, SIGUSR1);
}

int	main(void)
{
	int					pid;
	struct sigaction	sa;
	char				ch;

	ch = 0;
	sa.sa_sigaction = &ft_handle_usr;
	sa.sa_flags = SA_SIGINFO;
	sigaction(SIGUSR1, &sa, NULL);
	sigaction(SIGUSR2, &sa, NULL);
	pid = getpid();
	ft_printf("%d\n", pid);
	while (1)
	{
		ch = ft_receive_char();
		if (!ch)
			ft_putchar_fd('\n', 1);
		else if (ft_isprint(ch))
			ft_putchar_fd(ch, 1);
	}
	return (0);
}
