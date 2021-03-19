import { useBackend } from '../../backend';
import { Box, Button, NoticeBox } from '../../components';

/**
 * Displays a notice box showing the
 * `authenticated` and `rank` data fields if they exist.
 *
 * Also gives an option to log off (calls `logout` TGUI action)
 * @param {object} _properties
 * @param {object} context
 */
export const LoginInfo = (_properties, context) => {
  const { act, data } = useBackend(context);
  const {
    authenticated,
    rank,
  } = data;
  if (!data) {
    return;
  }
  return (
    <NoticeBox info>
      <Box display="inline-block" verticalAlign="middle">
        Вход в систему как: {authenticated} ({rank})
      </Box>
      <Button
        icon="sign-out-alt"
        content="Выйти и забрать карту"
        color="good"
        float="right"
        onClick={() => act('logout')}
      />
      <Box clear="both" />
    </NoticeBox>
  );
};
