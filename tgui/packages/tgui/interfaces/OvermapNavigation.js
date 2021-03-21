import { round } from 'common/math';
import { Fragment } from 'inferno';
import { useBackend } from "../backend";
import { Box, Button, Flex, Icon, LabeledList, ProgressBar, Section } from "../components";
import { Window } from "../layouts";
import { OvermapFlightData } from "./common/Overmap";

export const OvermapNavigation = (props, context) => {
  return (
    <Window width={380} height={530} resizable>
      <Window.Content>
        <OvermapNavigationContent />
      </Window.Content>
    </Window>
  );
};

export const OvermapNavigationContent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    sector,
    s_x,
    s_y,
    sector_info,
    viewing,
  } = data;
  return (
    <Fragment>
      <Section title="Местоположение" buttons={
        <Button
          icon="eye"
          selected={viewing}
          onClick={() => act("viewing")}>
          Смотреть карту
        </Button>
      }>
        <LabeledList>
          <LabeledList.Item label="Текущее положение">
            {sector}
          </LabeledList.Item>
          <LabeledList.Item label="Координаты">
            {s_x} : {s_y}
          </LabeledList.Item>
          <LabeledList.Item label="Доп. информация">
            {sector_info}
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section title="Данные полета">
        <OvermapFlightData disableLimiterControls />
      </Section>
    </Fragment>
  );
};
